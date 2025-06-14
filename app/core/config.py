import secrets
import os

from typing import Any, Dict, List, Optional, Union
from pydantic import AnyHttpUrl, PostgresDsn, validator, SecretStr
from pydantic_settings import BaseSettings
from pathlib import Path



class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    SECRET_KEY: str = secrets.token_urlsafe(32)
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8  # 8 days
    PROJECT_NAME: str = "FastAPI Project"

    # CORS
    BACKEND_CORS_ORIGINS: Any = []

    # Supabase Settings
    SUPABASE_URL: str = ""
    SUPABASE_KEY: str = ""
    SUPABASE_JWT_SECRET: str = ""

    @validator("BACKEND_CORS_ORIGINS", pre=True)
    def assemble_cors_origins(cls, v: str) -> Union[List[str], str]:
        return v.split(",")

    # Database
    POSTGRES_SERVER: str = "localhost"
    POSTGRES_USER: str = "postgres"
    POSTGRES_PASSWORD: str = "postgres"
    POSTGRES_DB: str = "app"
    SQLALCHEMY_DATABASE_URI: str = ""

    EQUIFAX_URL: str
    EQUIFAX_USER: str
    EQUIFAX_PASSWORD: str
    EQUIFAX_KEY: str
    EQUIFAX_APPLICATION: str

    @validator("SQLALCHEMY_DATABASE_URI", pre=True)
    def assemble_db_connection(cls, v: Optional[str], values: Dict[str, Any]) -> Any:
        return PostgresDsn.build(
            scheme="postgresql+asyncpg",
            username=values.get("POSTGRES_USER"),
            password=values.get("POSTGRES_PASSWORD"),
            host=values.get("POSTGRES_SERVER"),
            path=values.get('POSTGRES_DB') or '',
        ).encoded_string()
    # Paths
    BASE_DIR: Path = Path(__file__).resolve().parent.parent.parent

    # Environment
    ENV: str = "development"

    class Config:
        case_sensitive = True
        env_file = ".env"


settings = Settings()
