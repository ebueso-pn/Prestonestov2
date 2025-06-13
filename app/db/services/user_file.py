import uuid

from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from datetime import datetime

from app.db.base import BaseService
from app.db.models import UserFile

class UserFileDBService(BaseService):
    """Service for user file operations."""
    def __init__(self):
        super().__init__(UserFile)


    @staticmethod
    async def create_record(
        db: AsyncSession,
        *,
        user_id: uuid.UUID,
        file_type: str,
        file_path: str,
        uploaded_at: Optional[datetime] = None
    ) -> UserFile:
        obj = UserFile(
            user_id=user_id,
            file_type=file_type,
            file_path=file_path,
            uploaded_at=uploaded_at or datetime.utcnow()
        )
        db.add(obj)
        await db.commit()
        await db.refresh(obj)
        return obj

UserFileService = UserFileDBService()
