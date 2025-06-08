import logging
import json

from fastapi import FastAPI, Request, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError

from app.api.api import api_router
from app.core.config import settings

app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    version="0.1.0",
)

# Set all CORS enabled origins
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

@app.get("/", tags=["Health"])
async def health_check():
    """
    Root endpoint for health checks.
    """
    return {"status": "ok", "message": "Service is running"}

app.include_router(api_router, prefix=settings.API_V1_STR)

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    """
    Handle validation errors and ensure all error details are JSON serializable.
    Also logs the pretty error.
    """
    logger = logging.getLogger("uvicorn.error")

    def make_serializable(error):
        # Convert exception objects to strings for JSON serialization
        if "ctx" in error and "error" in error["ctx"]:
            error["ctx"]["error"] = str(error["ctx"]["error"])
        return error

    errors = [make_serializable(e) for e in exc.errors()]
    # Pretty log the error details and request info
    logger.error(
        "Validation error on path %s\nErrors:\n%s\nBody:\n%s",
        request.url.path,
        json.dumps(errors, indent=2, ensure_ascii=False),
        json.dumps(exc.body, indent=2, ensure_ascii=False)
    )
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content={
            "detail": errors,
            "body": exc.body,
        },
    )

@app.exception_handler(Exception)
async def generic_exception_handler(request: Request, exc: Exception):
    """
    Handle all uncaught exceptions and return a generic error response.
    Also logs the error details.
    """
    logger = logging.getLogger("uvicorn.error")
    logger.error(
        "Unhandled exception on path %s\nException: %s",
        request.url.path,
        str(exc),
        exc_info=True
    )
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={
            "detail": "Internal server error. Please try again later.",
            "error": str(exc)
        },
    )
