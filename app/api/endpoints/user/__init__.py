import logging
from typing import Any
from fastapi import APIRouter, Depends, HTTPException, Body, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import IntegrityError

from app.core.auth import get_current_user

from app.db.base import get_db, get_db_no_exp
from app.core.cache import get_user_cache_info_key
from app.db.models import User
from app.db.models.user_location import UserLocation as UserLocationModel
from app.utils.cache import cache_response

from app.db.services.user import UserService
from app.db.services.user_financials import UserFinancialService
from app.db.services.kyc import KYCService
from app.db.services.application import ApplicationService
from app.db.services.user_location import UserLocationService

from app.schemas.base import BaseResponse
from app.schemas.user_location import UserLocationCreate, UserLocation, UserLocationBase, UserLocationInDBBase
from app.schemas.user_financials import IncomeInfoSchemaRequest, UserFinancialsSchemaResponse, UserFinancialsSchema
from app.schemas.user import UserBase, UserFullInformationResponse, KYCGetMe
from app.schemas.shufti import ShuftiProKYCSchema
from app.schemas.kyc import KYCStatus, KYCType
from app.schemas.application import ApplicationCreate, ApplicationStatus, ApplicationUpdate, ApplicationBase

from app.process.shufti import verify_shufti
from app.process.equifax import EquifaxService

from .docs import create_user_financials_description, create_user_financials_summary

logger = logging.getLogger(__name__)
router = APIRouter()

@router.post("/update_financials",status_code=status.HTTP_201_CREATED,description=create_user_financials_description, summary=create_user_financials_summary)
async def update_user_financials(
    request: IncomeInfoSchemaRequest,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> Any:
    # Check if user_financials already exists for this user
    user_financials = await UserFinancialService.get_by_user_id(db=db, user_id=user.id)
    if user_financials:
        raise HTTPException(
            status_code=409,
            detail="Financial information already submitted for this user."
        )

    try:
        # Create new user financials
        user_financials = await UserService.create_user_financials(
            db=db,
            user_id=user.id,
            financials_data=request
        )
        return UserFinancialsSchemaResponse(
            success=True,
            message="User financials fetched successfully",
            data=user_financials
        )
    except Exception as e:
        logger.error(f"Error updating user financials: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="An error occurred while updating financial information."
        )

@router.get("/me",status_code=status.HTTP_200_OK)
async def get_me(
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> Any:
    """
    Get the current authenticated user.
    """

    user_financials = await UserFinancialService.get_by_user_id(db, user_id=user.id)
    if user_financials is None:
        logger.warning(f"User financials not found for user ID: {user.id}")

    parsed_financials = None
    if user_financials:
        parsed_financials = UserFinancialsSchema.from_orm(user_financials)

    application = None
    # Get the first pending application for the user (should only be one pending at a time)
    pending_application = await ApplicationService.get_first_pending_application_by_user_id(db=db, user_id=user.id)
    if pending_application:
        application = ApplicationBase.from_orm(pending_application)

    kyc_response = None
    kyc_status = await KYCService.get_shufti_and_equifax_status_by_user_id(db=db, user_id=user.id)
    if kyc_status:
        kyc_response = KYCGetMe(
            is_shufti_valid=kyc_status.get("shufti_status") == KYCStatus.APPROVED,
            is_equifax_valid=kyc_status.get("equifax_status")== KYCStatus.APPROVED
        )

    location_obj= None
    location = await UserLocationService.get_by_user_id(db=db, user_id=user.id)
    if location:
        location_obj = UserLocationInDBBase.from_orm(location)


    response = UserFullInformationResponse(
        success=True,
        message="User fetched successfully",
        user=UserBase.from_orm(user),
        financials=parsed_financials,
        application=application,
        location=location_obj,
        kyc=kyc_response
    )
    return response

@router.post("/update_location", status_code=status.HTTP_201_CREATED, response_model=UserLocation)
async def create_user_location(
    request: UserLocationCreate,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> Any:
    """
    Create a new user location for the authenticated user.
    """
    try:
        # Ensure the user_id is set to the authenticated user
        location = await UserLocationService.create(
            db=db,
            obj_in=UserLocationBase(
            user_id=user.id,
                **request.dict(exclude_unset=True),

            )
        )
        return UserLocation.from_orm(location)
    except IntegrityError as e:
        logger.error(f"Integrity error creating user location: {str(e)}")
        raise HTTPException(
            status_code=409,
            detail="A location for this user may already exist or invalid data provided."
        )
    except Exception as e:
        logger.error(f"Error creating user location: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="An error occurred while creating user location."
        )

@router.post("/kyc", status_code=status.HTTP_200_OK, response_model=BaseResponse)
async def user_kyc(
    body: ShuftiProKYCSchema  = Body(...),
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_no_exp)
) -> Any:
    """
        Test route: receive any body and write it as a file
    """
    is_shufti_valid = verify_shufti(user, shutfi_raw_response=body)

    await KYCService.create_kyc_record(
        db=db,
        user_id=user.id,
        kyc_type=KYCType.SHUFTI,
        content=body.dict(),
        status=KYCStatus.APPROVED if is_shufti_valid else KYCStatus.DENIED
    )

    if not is_shufti_valid:
        return BaseResponse(
            success=False,
            message="Shufti verification failed"
        )

    # Let's create a new application for the use
    application = await ApplicationService.create(
        db=db,
        obj_in=ApplicationCreate(
            user_id=user.id,
            status=ApplicationStatus.PENDING,
        )
    )


    # Now let's check equifax
    data_equifax = await EquifaxService.process_equifax_data("0801201420883")
    await KYCService.create_kyc_record(
        db=db,
        user_id=user.id,
        kyc_type=KYCType.EQUIFAX,
        content=data_equifax.data if data_equifax.data is not None else {},
        status=KYCStatus.APPROVED if data_equifax.eligible else KYCStatus.DENIED
    )

    if not data_equifax.eligible:
        await ApplicationService.update(
            db=db,
            id=application.id,
            obj_in=ApplicationUpdate(
                status=ApplicationStatus.REJECTED
            )
        )

        return BaseResponse(
            success=False,
            message="Equifax verification failed"
        )


    return BaseResponse(
        success=True,
        message="Verification successful"
    )
