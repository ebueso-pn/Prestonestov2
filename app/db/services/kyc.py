from app.db.base import BaseService
from app.db.models.kyc import KnowYourCustomer

class KYCDBService(BaseService):
    def __init__(self):
        super().__init__(KnowYourCustomer)


KYCService = KYCDBService()
