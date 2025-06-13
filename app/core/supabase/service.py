import logging
import requests

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

def upload_file_supabase_with_jwt(
    bucket: str,
    file_path: str,
    file_data: bytes,
    user_jwt: str,
    content_type: str = "application/octet-stream"
) -> dict:
    """
    Upload a file to a Supabase storage bucket using a user's JWT (for RLS).

    Args:
        bucket (str): The name of the Supabase storage bucket.
        file_path (str): The path (including filename) where the file will be stored in the bucket.
        file_data (bytes): The file data to upload.
        user_jwt (str): The user's JWT token.
        content_type (str): The MIME type of the file.

    Returns:
        dict: The response from Supabase storage REST API.
    """
    supabase_url = settings.SUPABASE_URL
    url = f"{supabase_url}/storage/v1/object/{bucket}/{file_path}"
    headers = {
        "Authorization": f"Bearer {user_jwt}",
        "Content-Type": content_type,
        "x-upsert": "true"
    }
    try:
        response = requests.post(url, headers=headers, data=file_data)
        if not response.ok:
            logger.error(f"Error uploading file with JWT: {response.text}")
            raise HTTPException(
                status_code=response.status_code,
                detail=f"Error uploading file: {response.text}"
            )
        return response.json() if response.content else {"status": "success"}
    except Exception as e:
        logger.error(f"Exception during file upload with JWT: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to upload file to Supabase with user JWT."
        )

def get_file_supabase_with_jwt(
    user_jwt: str,
    user_supabase_uid: str,
    bucket: str = "files"
) -> dict:
    """
    List files for a user in 'income_statement' and 'bank_accounts' subfolders of a Supabase storage bucket using the Supabase Python SDK.

    Args:
        user_jwt (str): The user's JWT token.
        user_supabase_uid (str): The user's Supabase UID.
        bucket (str): The name of the Supabase storage bucket.

    Returns:
        dict: Dictionary with subfolder names as keys and list of files as values.
    """
    supabase_url = settings.SUPABASE_URL
    result = {}
    try:
        # Create a Supabase client using the user's JWT for RLS
        user_client = create_client(supabase_url, user_jwt)
        for subfolder in ["income_statement", "bank_accounts"]:
            prefix = f"{subfolder}/{user_supabase_uid}/"
            response = user_client.storage.from_(bucket).list(prefix)
            # The SDK returns a dict with a 'data' key containing the list of files, or a list directly
            files = response.get("data") if isinstance(response, dict) and "data" in response else response
            result[subfolder] = files if files is not None else []
    except Exception as e:
        logger.error(f"Exception during file listing with SDK: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to list files using Supabase SDK: {e}"
        )
    return result

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
