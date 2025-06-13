import logging
from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException, Body, status, File, UploadFile, Form
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

from sqlalchemy.ext.asyncio import AsyncSession

from app.core.supabase.service import upload_file_supabase_with_jwt
from app.core.auth import get_current_user

from app.db.base import get_db, get_db_no_exp
from app.core.cache import get_user_cache_info_key
from app.db.models import User
from app.utils.cache import cache_response

from app.db.services.user import UserService
from app.db.services.user_financials import UserFinancialService
from app.db.services.kyc import KYCService
from app.db.services.application import ApplicationService
from app.db.services.user_file import UserFileDBService

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
security = HTTPBearer()

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

@router.post("/upload_files", status_code=status.HTTP_200_OK)
async def upload_files(
    files: List[UploadFile] = File(...),
    file_type: str = Form(..., regex="^(income|bank)$"),
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_no_exp),
    credentials: HTTPAuthorizationCredentials = Depends(security),
) -> Any:
    if file_type not in ["income", "bank"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid file type. Must be 'income' or 'bank'."
        )

    file_type_path = "income_statement" if file_type == "income" else "bank_accounts"
    user_jwt = credentials.credentials
    try:
        for file in files:
            contents = await file.read()
            storage_path = f"{file_type_path}/{user.supabase_uid}/{file.filename}"
            file_content_type = file.content_type

            if not file_content_type:
                ext = file.filename.split('.')[-1].lower()
                if ext in ["jpg", "jpeg"]:
                    file_content_type = "image/jpeg"
                elif ext == "png":
                    file_content_type = "image/png"
                elif ext == "gif":
                    file_content_type = "image/gif"
                elif ext == "pdf":
                    file_content_type = "application/pdf"
                else:
                    file_content_type = "application/octet-stream"


            upload_file_supabase_with_jwt(
                bucket="files",
                file_path=storage_path,
                file_data=contents,
                user_jwt=user_jwt,
                content_type=file.content_type or file_content_type
            )
            # Save metadata to DB
            user_file = await UserFileDBService.create_record(
                db=db,
                user_id=user.id,
                file_type=file_type,
                file_path=storage_path,
            )
            await file.close()
    except Exception as e:
        logger.exception("Error uploading files: %s", e)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="An error occurred while uploading files."
        )
    return BaseResponse(
        success=True,
        message="Files uploaded successfully",
    )
