from pydantic import BaseModel, EmailStr
from typing import Optional

from app.db.models.user import UserIDType
from app.schemas.base import BaseResponse
from app.schemas.user_financials import UserFinancialsSchema
from app.schemas.application import ApplicationBase
from app.schemas.user_location import UserLocationInDBBase

class UserBase(BaseModel):
    email: EmailStr
    phone_number: str
    id_number: str
    id_type: UserIDType
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    is_active: bool = False

    class Config:
        from_attributes=True

class UserCreate(UserBase):
    supabase_uid: str

class UserUpdate(UserBase):
    pass

class KYCGetMe(BaseModel):
    is_shufti_valid: Optional[bool] = None
    is_equifax_valid: Optional[bool] = None

class UserFullInformationResponse(BaseResponse):
    user: UserBase
    financials: Optional[UserFinancialsSchema] = None
    application: Optional[ApplicationBase] = None
    kyc: Optional[KYCGetMe] = None
    location: Optional[UserLocationInDBBase] = None
