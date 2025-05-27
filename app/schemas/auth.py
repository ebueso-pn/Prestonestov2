from typing import Optional, Dict, Any
from httpx._transports import default
from pydantic import BaseModel, EmailStr, Field, validator
import re

from pydantic.json_schema import Examples
from app.db.models.user import UserIDType
from app.schemas.user import UserCreate

class RegistrationRequest(BaseModel):
    """Schema for user registration"""
    email: EmailStr = Field(..., description="User email", examples=["user@example.com"])
    phone_number: str = Field(..., description="User phone number", examples=["+1234567890"])
    password: str = Field(
        ...,
        description="User password",
        min_length=8,
        examples=["strongP@ssword123"]
    )
    id_type: UserIDType= Field(description="User ID type", examples=[UserIDType.DNI, UserIDType.PASSPORT], default=UserIDType.DNI)
    id_number: str = Field(..., description="User ID number", examples=["12345678A"])

    @validator('password')
    def password_strength(cls, v):
        """Validate password strength"""
        if not re.search(r'[A-Z]', v):
            raise ValueError('Password must contain at least one uppercase letter')
        if not re.search(r'[a-z]', v):
            raise ValueError('Password must contain at least one lowercase letter')
        if not re.search(r'[0-9]', v):
            raise ValueError('Password must contain at least one digit')
        if not re.search(r'[^A-Za-z0-9]', v):
            raise ValueError('Password must contain at least one special character')
        return v

    @validator('id_type')
    def validate_id_type(cls, v):
        """Validate and convert id_type string to UserIDType enum"""
        v = v.upper()  # Make case-insensitive
        if v == "DNI":
            return UserIDType.DNI.value
        elif v == "PASSPORT":
            return UserIDType.PASSPORT.value
        else:
            raise ValueError('id_type must be either "DNI" or "PASSPORT"')


    class Config:
        json_schema_extra = {
            "example": {
                "email": "user@example.com",
                "phone_number": "+1234567890",
                "password": "strongP@ssword123",
                "id_number": "12345678A",
                "id_type": "dni"
            }
        }
