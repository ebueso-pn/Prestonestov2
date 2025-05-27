from datetime import datetime, timedelta
from typing import Optional, Dict, Any, Union

from fastapi import Depends, HTTPException, status, Request
from fastapi.security import OAuth2PasswordBearer, HTTPBearer, HTTPAuthorizationCredentials
from jose import jwt, JWTError
from pydantic import BaseModel, EmailStr

from app.core.config import settings
from app.core.supabase import auth

# Bearer token scheme for API routes
security = HTTPBearer()

# Define user models
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
    id: str
    email: EmailStr
    is_active: bool = True
    is_superuser: bool = False
    role: str = "user"
    app_metadata: Optional[Dict[str, Any]] = None
    user_metadata: Optional[Dict[str, Any]] = None
    
async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security)
) -> User:
    """
    Dependency to extract and validate the current user from a JWT token.
    
    Args:
        credentials: The Bearer token from the request
        
    Returns:
        User: The authenticated user object
        
    Raises:
        HTTPException: If authentication fails for any reason
    """
    try:
        token = credentials.credentials
        
        # Verify token with Supabase
        user_response = auth().get_user(token)
        user_data = user_response.dict()
        
        # Extract user data
        if not user_data:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate credentials",
                headers={"WWW-Authenticate": "Bearer"},
            )
        
        # Map Supabase user to our User model
        user = User(
            id=user_data.get("id"),
            email=user_data.get("email", ""),
            app_metadata=user_data.get("app_metadata", {}),
            user_metadata=user_data.get("user_metadata", {}),
            is_active=True,  # We assume all Supabase users are active
            role=user_data.get("app_metadata", {}).get("role", "user"),
        )
        
        return user
        
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Invalid authentication credentials: {str(e)}",
            headers={"WWW-Authenticate": "Bearer"},
        )

async def get_optional_user(
    request: Request
) -> Optional[User]:
    """
    Similar to get_current_user but doesn't raise an exception if no user is found.
    This is useful for routes that can be accessed both authenticated and anonymously.
    
    Args:
        request: The request object
        
    Returns:
        Optional[User]: The authenticated user or None
    """
    auth_header = request.headers.get("Authorization")
    if not auth_header:
        return None
    
    try:
        token_type, token = auth_header.split()
        if token_type.lower() != "bearer":
            return None
        
        # Verify token with Supabase
        user_response = auth().get_user(token)
        user_data = user_response.dict()
        
        if not user_data:
            return None
        
        # Map Supabase user to our User model
        user = User(
            id=user_data.get("id"),
            email=user_data.get("email", ""),
            app_metadata=user_data.get("app_metadata", {}),
            user_metadata=user_data.get("user_metadata", {}),
            is_active=True,
            role=user_data.get("app_metadata", {}).get("role", "user"),
        )
        
        return user
        
    except Exception:
        return None

# Permission utilities
def is_admin(user: User) -> bool:
    """Check if user has admin role"""
    return user.role == "admin" or user.is_superuser

def require_admin(user: User = Depends(get_current_user)) -> User:
    """Dependency that only allows admin users"""
    if not is_admin(user):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Insufficient permissions",
        )
    return user