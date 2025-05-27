import logging

from typing import Any, Dict, Optional
from fastapi import APIRouter, Depends, HTTPException, status, Request, BackgroundTasks
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.supabase import auth
from app.db.base import get_db
from app.db.services.user import UserService
from app.schemas.auth import RegistrationRequest
from app.schemas.base import AuthResponse
from app.schemas.methods import registration_to_user_create

logger = logging.getLogger(__name__)
router = APIRouter()

@router.post("/register", response_model=AuthResponse, status_code=status.HTTP_201_CREATED)
async def register(
    request: RegistrationRequest,
    db: AsyncSession = Depends(get_db)
) -> Any:
    """
    Register a new user with Supabase Auth.

    This endpoint:
    1. Checks if user exists in our database
    2. Validates user status
    3. Creates a user in Supabase Auth if not exists or not validated
    """

    existing_user = await UserService.get_by_email(db, email=request.email)
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User already exists with that email."
        )

    existing_user = await UserService.get_by_dni(db, dni=request.id_number)
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User already exists with that DNI."
        )

    # If no existing user, proceed with registration
    supabase_response = auth().sign_up({
        "email": request.email,
        "password": request.password,
        "options": {
            "data": {
                "phone_number": request.phone_number,
                "id_type": request.id_type.value,
                "id_number": request.id_number
            }
        }
    })

    if not supabase_response.user:
        print("Registration failed xdd", supabase_response)
        logger.error("Registration failed xddd", supabase_response)
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Registration failed xddd"
        )

    await UserService.create(db, obj_in= registration_to_user_create(request, supabase_response.user.id))

    return AuthResponse(
        success=True,
        message="User registered successfully",
        data={"supabase_uid": supabase_response.user.id}
    )

'''
@router.post("/login", response_model=Token)
async def login(
    request: LoginRequest,
    db: Session = Depends(get_db)
) -> Any:
    """
    Authenticate a user with Supabase Auth and get JWT tokens.
    """
    try:
        # Login with Supabase
        auth_response = auth().sign_in_with_password({
            "email": request.email,
            "password": request.password
        })

        # Extract user and session data
        user_data = auth_response.user
        session = auth_response.session

        if not user_data or not session:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect email or password"
            )

        # Update last login in our database
        user_profile = db.query(UserProfile).filter(
            UserProfile.supabase_uid == user_data.id
        ).first()

        if user_profile:
            from datetime import datetime
            user_profile.last_login = datetime.utcnow()
            db.commit()

        # Return token data
        return {
            "access_token": session.access_token,
            "token_type": "bearer",
            "expires_at": session.expires_at,
            "refresh_token": session.refresh_token,
            "user": {
                "id": user_data.id,
                "email": user_data.email,
                "user_metadata": user_data.user_metadata
            }
        }

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Authentication failed: {str(e)}"
        )

@router.post("/refresh", response_model=Token)
async def refresh_token(
    request: RefreshTokenRequest
) -> Any:
    """
    Refresh an access token using a refresh token.
    """
    try:
        # Call Supabase refresh token
        refresh_response = auth().refresh_session({
            "refresh_token": request.refresh_token
        })

        session = refresh_response.session
        user = refresh_response.user

        if not session or not user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid refresh token"
            )

        # Return new tokens
        return {
            "access_token": session.access_token,
            "token_type": "bearer",
            "expires_at": session.expires_at,
            "refresh_token": session.refresh_token,
            "user": {
                "id": user.id,
                "email": user.email,
                "user_metadata": user.user_metadata
            }
        }

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Token refresh failed: {str(e)}"
        )

@router.post("/forgot-password", response_model=AuthResponse)
async def forgot_password(
    request: PasswordResetRequest
) -> Any:
    """
    Request a password reset email for a user.
    """
    try:
        # Request password reset with Supabase
        auth().reset_password_email(request.email)

        return {
            "success": True,
            "message": "Password reset instructions sent to your email"
        }

    except Exception as e:
        # We don't want to reveal if an email exists or not for security reasons
        return {
            "success": True,
            "message": "If your email is registered, you will receive password reset instructions"
        }

@router.post("/reset-password", response_model=AuthResponse)
async def reset_password(
    request: PasswordResetConfirmRequest
) -> Any:
    """
    Reset a user's password using a reset token.
    """
    try:
        # Reset password with Supabase
        auth().verify_otp({
            "email": request.email,
            "token": request.token,
            "type": "recovery"
        })

        # Update password
        # Note: This part may need adjustment based on Supabase's actual API
        auth().update_user({
            "password": request.password
        })

        return {
            "success": True,
            "message": "Password updated successfully"
        }

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Password reset failed: {str(e)}"
        )

@router.post("/logout", response_model=AuthResponse)
async def logout(
    user: User = Depends(get_current_user)
) -> Any:
    """
    Log out a user by invalidating their session in Supabase.
    """
    try:
        # Sign out with Supabase
        auth().sign_out()

        return {
            "success": True,
            "message": "Logged out successfully"
        }

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Logout failed: {str(e)}"
        )

@router.get("/me", response_model=UserResponse)
async def get_current_user_info(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """
    Get current user information from both Supabase Auth and our database.
    """
    # Get user profile from our database
    user_profile = db.query(UserProfile).filter(
        UserProfile.supabase_uid == current_user.id
    ).first()

    if not user_profile:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User profile not found"
        )

    return user_profile
'''
