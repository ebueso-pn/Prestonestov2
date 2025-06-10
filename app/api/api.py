from fastapi import APIRouter

from app.api.endpoints import auth, user, application

api_router = APIRouter()

api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
api_router.include_router(user.router, prefix="/user", tags=["api"])
api_router.include_router(application.router, prefix="/application", tags=["application"])
