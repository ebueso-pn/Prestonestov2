from pydantic import BaseModel, Field, EmailStr
from datetime import datetime
from typing import Optional
from enum import Enum

from app.db.models.user import UserIDType


class UserBase(BaseModel):
    email: EmailStr
    phone_number: str
    id_number: str
    id_type: UserIDType
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    is_active: bool = False

class UserCreate(UserBase):
    supabase_uid: str

class UserUpdate(UserBase):
    pass
