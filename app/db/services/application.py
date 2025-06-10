import uuid

from sqlalchemy.ext.asyncio import AsyncSession


from app.db.base import BaseService
from app.db.models.application import Application, ApplicationStatus

class ApplicationDBService(BaseService):
    def __init__(self):
        super().__init__(Application)

    async def get_first_pending_application_by_user_id(self, db: AsyncSession, *, user_id: uuid.UUID) -> Application | None:
        """
        Get the first pending application.
        """
        result = await self.get_by(
            db=db,
            order_by=Application.date_applied,
            desc=False,
            status=ApplicationStatus.PENDING,
            user_id=user_id
        )
        print(result)
        print("monda")
        if isinstance(result, list) or isinstance(result, tuple):
            return result[0] if result else None
        return result


ApplicationService = ApplicationDBService()
