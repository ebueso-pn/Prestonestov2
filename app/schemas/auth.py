import re
import uuid

from pydantic import BaseModel, EmailStr, Field, validator
from typing import Optional

from app.schemas.user import UserCreate
from app.schemas.base import BaseResponse
from app.db.models.user import UserIDType

class AuthResponse(BaseResponse):
    supabase_uid: Optional[str] = Field(
        None,
        description="The user's Supabase UID, if applicable",
        examples=["1234-5678-9012", "abcd-efgh-ijkl", None]
    )
    access_token: Optional[str] = Field(
        None,
        description="The access token for authenticated sessions",
        examples=[
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
            None
        ]
    )
    refresh_token: Optional[str] = Field(
        None,
        description="The refresh token for session renewal",
        examples=[
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
            None
        ]
    )
    user_id: Optional[uuid.UUID] = Field(
        None,
        description="The user's Supabase UID, if applicable",
        examples=["123e4567-e89b-12d3-a456-426614174000", None]
    )

    class Config:
        json_schema_extra = {
            "example": {
                "success": True,
                "message": "Authentication successful",
                "data": {"role": "user"},
                "supabase_uid": "1234-5678-9012",
                "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
                "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
                "user_id": "42"
            }
        }

class LoginRequest(BaseModel):
    """
    Schema for user login requests.

    Attributes:
        email (EmailStr): The user's email address. Must be a valid email format.
        password (str): The user's password. Must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.

    Example:
        {
            "email": "user@example.com",
            "password": "strongP@ssword123"
        }
    """
    email: EmailStr = Field(
        ...,
        description="User email address. Must be a valid email format.",
        examples=["user@example.com"]
    )
    password: str = Field(
        ...,
        description=(
            "User password. Must be at least 8 characters long and contain at least one uppercase letter, "
            "one lowercase letter, one digit, and one special character."
        ),
        min_length=8,
        examples=["strongP@ssword123"]
    )

    @validator('password')
    def password_strength(cls, v):
        """Validate password strength"""
        if not re.search(r'[0-9]', v):
            raise ValueError('Password must contain at least one digit')
        return v

    class Config:
        json_schema_extra = {
            "example": {
                "email": "user@example.com",
                "password": "strongP@ssword123"
            }
        }

class RegistrationRequest(LoginRequest):
    """
    Schema for user registration.

    Attributes:
        email (EmailStr): User email address.
        phone_number (str): User phone number in the format +504XXXXXXXX.
        password (str): User password, must meet strength requirements.
        id_type (UserIDType): Type of user identification (DNI or PASSPORT).
        id_number (str): User identification number.
    """
    phone_number: str = Field(..., description="User phone number", min_length=9, max_length=12, pattern=r'^(\+504)[0-9]{8}$', examples=["+50412345678"])

    id_type: UserIDType= Field(description="User ID type", examples=[UserIDType.DNI, UserIDType.PASSPORT], default=UserIDType.DNI)
    id_number: str = Field(..., description="User ID number", examples=["12345678A"])


    @validator('id_type', pre=True)
    def validate_id_type(cls, v):
        """Validate and convert id_type string to UserIDType enum"""
        v = v.upper()  # Make case-insensitive
        if v == "DNI":
            return UserIDType.DNI.value
        elif v == "PASSPORT":
            return UserIDType.PASSPORT.value
        else:
            raise ValueError('id_type must be either "DNI" or "PASSPORT"')

    class Config:  # type: ignore[override]
        json_schema_extra = {
            "example": {
                "email": "user@example.com",
                "phone_number": "+1234567890",
                "password": "strongP@ssword123",
                "id_number": "12345678A",
                "id_type": "dni"
            }
        }


def registration_to_user_create(
    registration_data: RegistrationRequest,
    supabase_uid: str
) -> UserCreate:
    """Transform RegistrationRequest to UserCreate"""
    return UserCreate(
        email=registration_data.email,
        phone_number=registration_data.phone_number,
        id_number=registration_data.id_number,
        id_type=registration_data.id_type,
        first_name=None,
        last_name=None,
        is_active=False,
        supabase_uid=supabase_uid
    )
