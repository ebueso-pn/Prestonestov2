import logging
from typing import Optional
from functools import lru_cache
from fastapi import  HTTPException, status
from supabase import create_client, Client
from gotrue.types import AuthResponse

from app.core.config import settings

logger = logging.getLogger(__name__)

class SupabaseClient:
    """
    Singleton class to manage Supabase client instance and provide utilities
    for authentication and database operations.
    """
    _instance: Optional[Client] = None

    @classmethod
    def get_client(cls) -> Client:
        """
        Get or create a Supabase client instance.

        Returns:
            Client: Supabase client instance
        """
        if cls._instance is None:
            supabase_url = settings.SUPABASE_URL
            supabase_key = settings.SUPABASE_KEY

            if not supabase_url or not supabase_key:
                raise ValueError(
                    "Supabase URL and key must be provided. "
                    "Set SUPABASE_URL and SUPABASE_KEY environment variables."
                )

            cls._instance = create_client(supabase_url, supabase_key)

        return cls._instance

    @classmethod
    def reset_client(cls) -> None:
        """Reset the client instance, useful for testing."""
        cls._instance = None

@lru_cache()
def _get_supabase() -> Client:
    """
    Get a cached Supabase client instance.

    Returns:
        Client: Supabase client instance
    """
    return SupabaseClient.get_client()

# Convenience direct accessors
def _auth():
    """Get Supabase auth client."""
    return _get_supabase().auth

def login_supabase(email: str, password: str) -> AuthResponse:
    """Log in a user with email and password using Supabase auth."""
    try:
        return _auth().sign_in_with_password({"email": email, "password": password})
    except Exception as e:
        logger.error(f"Error logging in: {e}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password"
        )

def sign_up_supabase(data):
    """Sign up a user with email and password."""
    try:
        return _auth().sign_up(data)
    except Exception as e:
        logger.error(f"Error signing up: {e}")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User already exists. Don't register again."
        )

def get_user_supabase(token: str):
    """
    Get user information from Supabase using a JWT token.

    Args:
        token (str): JWT token to get user information

    Returns:
        dict: User information if the token is valid
    """
    try:
        return _auth().get_user(token)
    except Exception as e:
        logger.error(f"Error getting user: {e}")
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Invalid credentials")

def verify_token_supabase(token: str) -> bool:
    """
    Verify a JWT token using Supabase auth.

    Args:
        token (str): JWT token to verify

    Returns:
        bool: True if the token is valid, False otherwise
    """
    try:
        _auth().get_user(token)
        return True
    except Exception as e:
        logger.error(f"Error verifying token: {e}")
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Invalid credentials")
