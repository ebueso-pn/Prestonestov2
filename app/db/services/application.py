from app.db.base import BaseService
from app.db.models.application import Application

class ApplciationDBService(BaseService):
    def __init__(self):
        super().__init__(Application)


ApplicationService = ApplciationDBService()
