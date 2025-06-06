import logging
from typing import Any
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.base import get_db
from app.db.models import User
from app.db.services.user import UserService
from app.db.services.user_financials import UserFinancialService
from app.core.auth import get_current_user
from app.schemas.user_financials import IncomeInfoSchemaRequest, UserFinancialsSchemaResponse, UserFinancialsSchema
from app.schemas.user import UserBase, UserFullInformationResponse

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

    parsed_financials=None
    if user_financials:
        parsed_financials = UserFinancialsSchema.from_orm(user_financials)

    application = None
    return UserFullInformationResponse(
        success=True,
        message="User fetched successfully",
        user=UserBase.from_orm(user),
        financials=parsed_financials,
        application=application
    )

@router.post("/shufti", status_code=status.HTTP_200_OK)
async def user_shufti(
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> Any:
    """
    Get Shufti KYC data for the current user.
    """
    kyc_data = await UserFinancialService.get_shufti_kyc_data(db, user_id=user.id)
    if not kyc_data:
        raise HTTPException(
            status_code=404,
            detail="Shufti KYC data not found for this user."
        )
    return kyc_data
