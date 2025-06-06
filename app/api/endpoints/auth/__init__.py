import logging
from typing import Any
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.jwt import JwtManager
from app.core.supabase import sign_up_supabase, verify_token_supabase, login_supabase
from app.db.base import get_db
from app.db.models.user import User
from app.db.services.user import UserService
from app.schemas.auth import AuthResponse, RegistrationRequest, LoginRequest, registration_to_user_create

from .docs import register_description_docs, register_summary_docs, login_description_docs, login_summary_docs

logger = logging.getLogger(__name__)
router = APIRouter()

@router.post("/register", response_model=AuthResponse, status_code=status.HTTP_201_CREATED, description=register_description_docs, summary=register_summary_docs)
async def register(
    request: RegistrationRequest,
    db: AsyncSession = Depends(get_db)
) -> Any:
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
    supabase_response = sign_up_supabase({
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
        print("Registration failed", supabase_response)
        logger.error("Registration failed", supabase_response)
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Registration failed"
        )

    user: User = await UserService.create(db, obj_in=registration_to_user_create(request, supabase_response.user.id))

    try:
        tokens = JwtManager.create_token_pair(subject=user)
        verify_token_supabase(tokens.access_token)
    except Exception as e:
        logger.error(f"Failed to create JWT tokens: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to generate authentication tokens"
        )

    return AuthResponse(
        success=True,
        message="User registered successfully",
        supabase_uid=supabase_response.user.id,
        access_token=tokens.access_token,
        refresh_token=tokens.refresh_token,
        user_id=user.id
    )

@router.post("/login", response_model=AuthResponse, status_code=status.HTTP_200_OK, description=login_description_docs, summary=login_summary_docs)
async def login(
    request: LoginRequest,
    db: AsyncSession = Depends(get_db)
) -> Any:
    user = await UserService.get_by_email(db, email=request.email)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password."
        )

    # Verify Supabase credentials
    # This will raise an exception if the credentials are invalid
    if not user.supabase_uid:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User not registered with Supabase."
        )

    supabase_response = login_supabase(email=request.email, password=request.password)

    if not supabase_response.user or not supabase_response.session:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password."
        )

    acccess_token = supabase_response.session.access_token
    refresh_token = supabase_response.session.refresh_token
    if not acccess_token or not refresh_token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Failed to retrieve access or refresh token from Supabase."
        )

    return AuthResponse(
        success=True,
        message="Login successful",
        supabase_uid=user.supabase_uid,
        access_token=acccess_token,
        refresh_token=refresh_token,
        user_id=user.id
    )
