import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.db.base import BaseService
from app.db.models.user_location import UserLocation

class UserLocationDBService(BaseService):
    def __init__(self):
        super().__init__(UserLocation)

    async def get_by_user_id(self, db: AsyncSession, *, user_id: uuid.UUID):
        """
        Get the latest user location for a given user_id.
        """
        results = await self.get_by(
            db=db,
            user_id=user_id,
            order_by=UserLocation.created_at,
            desc=True,
            limit=1,
        )
        return results[0] if results else None

UserLocationService = UserLocationDBService()
