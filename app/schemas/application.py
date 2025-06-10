from typing import Optional
from uuid import UUID
from datetime import datetime
from pydantic import BaseModel, Field

from app.db.models.application import ApplicationStatus

class ApplicationBase(BaseModel):
    user_id: UUID = Field(..., description="ID of the user who applied")
    amount: Optional[float] = Field(default=None, description="Requested loan amount")
    months: Optional[int] = Field(default=None, description="Loan duration in months")
    installment: Optional[float] = Field(default=None, description="Installment amount")
    status: ApplicationStatus = Field(..., description="Status of the application")

    class Config:
        from_attributes = True

class ApplicationCreate(ApplicationBase):
    pass

class ApplicationCreateRequired(BaseModel):
    amount: float = Field(..., description="Requested loan amount")
    months: int = Field(..., description="Loan duration in months")
    installment: float = Field(..., description="Installment amount")

class ApplicationUpdate(BaseModel):
    amount: Optional[float] = Field(default=None, description="Requested loan amount")
    months: Optional[int] = Field(default=None, description="Loan duration in months")
    installment: Optional[float] = Field(default=None, description="Installment amount")
    status: Optional[ApplicationStatus] = Field(default=None, description="Status of the application")

class ApplicationInDBBase(ApplicationBase):
    id: UUID = Field(..., description="Application ID")
    user_id: UUID = Field(..., description="ID of the user who applied")
    date_applied: Optional[datetime] = Field(None, description="Date when the application was created")

    class Config:
        from_attributes = True

class Application(ApplicationInDBBase):
    pass
