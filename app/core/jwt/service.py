import logging
from jose import JWTError, jwt, ExpiredSignatureError
from datetime import datetime, timedelta
from typing import Optional
from fastapi import HTTPException, status

from app.core.config import settings
from app.db.models.user import User
from app.db.base import Base

from app.core.jwt.schemas import TokenData, TokenPayload

logger = logging.getLogger("uvicorn.error")

class CustomJWTManager:
    def __init__(self, secret_key: str, algorithm: str = "HS256"):
        self.secret_key = secret_key
        self.algorithm = algorithm
        self.audience: str = "authenticated"
        self.access_token_expire_hours = 24
        self.refresh_token_expire_hours = 30 * 24

    def _token_payload(self, subject: User, token_type: str, expires_delta: Optional[timedelta] = None) -> dict:
        if expires_delta:
            expire = datetime.utcnow() + expires_delta
        else:
            expire = datetime.utcnow() + timedelta(hours=self.access_token_expire_hours)

        to_encode = {
            "sub": subject.supabase_uid,
            "name": subject.email,
            "iat": datetime.utcnow(),
            "aud": self.audience,
            "iss": "prestonesto",
            "exp": expire,
            "token_type": token_type,
            "role": self.audience
        }

        return to_encode

    def create_access_token(self, subject: User, expires_delta: Optional[timedelta] = None) -> str:
        """
        Create a new access token

        Args:
            subject: Usually the user ID or email
            expires_delta: Custom expiration time (optional)

        Returns:
            Encoded JWT access token
        """
        to_encode = self._token_payload(subject, "access", expires_delta)
        encoded_jwt = jwt.encode(to_encode, self.secret_key, algorithm=self.algorithm)
        return encoded_jwt

    def create_refresh_token(self, subject: User, expires_delta: Optional[timedelta] = None) -> str:
        """
        Create a new refresh token

        Args:
            subject: Usually the user ID or email
            expires_delta: Custom expiration time (optional)

        Returns:
            Encoded JWT refresh token
        """
        to_encode = self._token_payload(subject, "refresh", expires_delta)
        encoded_jwt = jwt.encode(to_encode, self.secret_key, algorithm=self.algorithm)
        return encoded_jwt

    def create_token_pair(self, subject: Base | User) -> TokenData:
        """
        Create both access and refresh tokens

        Args:
            subject: Usually the user ID or email

        Returns:
            TokenData object containing both tokens
        """
        access_token = self.create_access_token(subject)
        refresh_token = self.create_refresh_token(subject)

        return TokenData(
            access_token=access_token,
            refresh_token=refresh_token
        )

    def verify_token(self, token: str, expected_token_type: str = "access") -> TokenPayload:
        """
        Verify and decode a JWT token

        Args:
            token: The JWT token to verify
            expected_token_type: Expected token type ("access" or "refresh")

        Returns:
            TokenPayload object with decoded data

        Raises:
            HTTPException: If token is invalid or expired
        """
        try:
            payload = jwt.decode(token, self.secret_key, algorithms=[self.algorithm], audience=self.audience)
            return TokenPayload(**payload)

        except ExpiredSignatureError:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token has expired"
            )
        except JWTError as e:
            logger.error(f"JWT verification failed: {e}")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate credentials"
            )


JwtManager = CustomJWTManager(secret_key=settings.SUPABASE_JWT_SECRET)
