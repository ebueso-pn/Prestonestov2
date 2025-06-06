import logging
import time
import traceback
from functools import wraps

from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

from app.core.jwt import JwtManager
from app.db.base import get_db
from app.db.models.user import User

security = HTTPBearer()
logger = logging.getLogger("uvicorn.error")

def async_ttl_cache(ttl_seconds=600):
    def decorator(func):
        cache = {}

        @wraps(func)
        async def wrapper(token: str, db):
            now = time.time()
            entry = cache.get(token)
            if entry:
                value, timestamp = entry
                if now - timestamp < ttl_seconds:
                    return value
            value = await func(token, db)
            cache[token] = (value, now)
            return value
        return wrapper
    return decorator

@async_ttl_cache(ttl_seconds=600)
async def get_user_from_token(token: str, db):
    from app.db.services.user import UserService  # Local import to avoid circular

    try:
        payload = JwtManager.verify_token(token, expected_token_type="access")

        supabase_uid = payload.sub
        if not supabase_uid or not isinstance(supabase_uid, str):
            logger.error("Could not validate credentials: Supabase UID missing or invalid")
            return None

        db_user = await UserService.get_by_supabase_uid(db, supabase_uid=supabase_uid)
        return db_user
    except HTTPException as e:
        logger.error(f"HTTPException during token verification: {traceback.format_exc()}")
        logger.error(f"JWT verification failed: {e.detail}")
        return None
    except Exception as e:
        logger.error(
            "Unexpected error during token verification: %s\nTraceback:\n%s",
            str(e)
        )
        return None

async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security),
    db=Depends(get_db),
) -> User:
    """
    Dependency to extract and validate the current user from a JWT token.
    """
    try:
        token = credentials.credentials

        db_user = await get_user_from_token(token, db)
        if not db_user:
            logger.error("User not found or invalid token")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid authentication credentials",
                headers={"WWW-Authenticate": "Bearer"},
            )

        return db_user
    except Exception as e:
        logger.error("Exception occurred during user authentication:\n%s", traceback.format_exc())
        logger.error(f"Authentication error: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
