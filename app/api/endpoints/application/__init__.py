import logging
from typing import Any
from fastapi import APIRouter, Depends, HTTPException, Body, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.auth import get_current_user

from app.db.base import get_db, get_db_no_exp
from app.core.cache import get_user_cache_info_key
from app.db.models import User
from app.utils.cache import cache_response

from app.db.services.user import UserService
from app.db.services.user_financials import UserFinancialService
from app.db.services.kyc import KYCService
from app.db.services.application import ApplicationService

from app.schemas.base import BaseResponse
from app.schemas.user_financials import IncomeInfoSchemaRequest, UserFinancialsSchemaResponse, UserFinancialsSchema
from app.schemas.user import UserBase, UserFullInformationResponse, KYCGetMe
from app.schemas.shufti import ShuftiProKYCSchema
from app.schemas.kyc import KYCStatus, KYCType
from app.schemas.application import ApplicationCreateRequired, ApplicationStatus, ApplicationUpdate

from app.process.shufti import verify_shufti
from app.process.equifax import EquifaxService


logger = logging.getLogger(__name__)
router = APIRouter()

@router.post("/params",status_code=status.HTTP_200_OK,)
async def update_application_initial_params(
    request: ApplicationCreateRequired,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> Any:
    # Get the first pending application for the user (should only be one pending at a time)
    pending_application = await ApplicationService.get_first_pending_application_by_user_id(db=db, user_id=user.id)
    if not pending_application:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="You shouldn't be here, no pending apps."
        )

    # Update the pending application with the new values from the request
    updated_application = await ApplicationService.update(
        db=db,
        id=pending_application.id,
        obj_in=request
    )

    return BaseResponse(
        success=True,
        message="Application parameters updated successfully",
    )
