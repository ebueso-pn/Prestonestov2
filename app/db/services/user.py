from typing import List, Optional, Dict, Any, Sequence, Union, Type
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from pydantic import BaseModel, EmailStr

from app.db.models.user import User, UserIDType
from app.db.base import Base, BaseService

class UserDBService(BaseService):
    """Service for user operations"""
    def __init__(self):
        super().__init__(User)

    async def get_by_dni(self, db: AsyncSession, *, dni: str) -> Optional[User]:
        """Get a user by email or dni"""
        query = select(User).where(
            (User.id_number == dni) & (User.id_type == UserIDType.DNI)
        )
        result = await db.execute(query)
        return result.scalars().first()

    async def get_by_email(self, db: AsyncSession, *, email: str) -> Optional[User]:
        """Get a user by email or dni"""
        query = select(User).where(
            (User.email == email)
        )
        result = await db.execute(query)
        return result.scalars().first()

    async def get_by_supabase_uid(self, db: AsyncSession, *, supabase_uid: str) -> Optional[User]:
        """Get a user by Supabase UID"""
        query = select(User).where(User.supabase_uid == supabase_uid)
        result = await db.execute(query)
        return result.scalars().first()



UserService = UserDBService()
