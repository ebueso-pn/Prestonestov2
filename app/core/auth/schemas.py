from uuid import UUID
from datetime import datetime
from typing import Optional, Dict, Any
from pydantic import BaseModel, EmailStr

class UserToken(BaseModel):
    """Schema for token data extracted from JWT"""
    sub: str  # user id
    email: Optional[EmailStr] = None
    exp: Optional[datetime] = None
    role: Optional[str] = "user"
    app_metadata: Optional[Dict[str, Any]] = None
    user_metadata: Optional[Dict[str, Any]] = None

class User(BaseModel):
    """Base user model with Supabase fields"""
    id: UUID
    supabase_uid: str
    email: EmailStr
    is_active: bool = True
    is_superuser: bool = False
    role: str = "user"
    app_metadata: Optional[Dict[str, Any]] = None
    user_metadata: Optional[Dict[str, Any]] = None
