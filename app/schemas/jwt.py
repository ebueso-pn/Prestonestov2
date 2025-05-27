from typing import Optional, Dict, Any
from httpx._transports import default
from pydantic import BaseModel, EmailStr, Field, validator
import re

from pydantic.json_schema import Examples


class Token(BaseModel):
    """Schema for JWT token response"""
    access_token: str
    token_type: str
    expires_at: Optional[int] = None
    refresh_token: Optional[str] = None
    user: Optional[Dict[str, Any]] = None

class TokenPayload(BaseModel):
    """Schema for token payload data"""
    sub: Optional[str] = None
    exp: Optional[int] = None

class LoginRequest(BaseModel):
    """Schema for login request"""
    email: EmailStr = Field(..., description="User email", examples=["user@example.com"])
    password: str = Field(..., description="User password",min_length=8,examples=["strongP@ssword123"])

    class Config:
        json_schema_extra = {
            "example": {
                "email": "user@example.com",
                "password": "strongP@ssword123"
            }
        }

class PasswordResetRequest(BaseModel):
    """Schema for password reset request"""
    email: EmailStr = Field(..., description="User email", examples=["user@example.com"])

class PasswordResetConfirmRequest(BaseModel):
    """Schema for password reset confirmation"""
    token: str = Field(..., description="Password reset token")
    password: str = Field(
        ...,
        description="New password",
        min_length=8,
        examples=["newStrongP@ssword123"]
    )

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

class RefreshTokenRequest(BaseModel):
    """Schema for token refresh request"""
    refresh_token: str = Field(..., description="Refresh token")
