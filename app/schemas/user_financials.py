
import datetime
from enum import Enum
from uuid import UUID
from typing import List
from pydantic import BaseModel, Field

from app.schemas.base import BaseResponse

class MainIncomeSourceEnum(str, Enum):
    salary = "salary"
    own_business = "own_business"
    others = "others"
    remittances = "remittances"

class IncomeInfoSchemaRequest(BaseModel):
    first_name: str = Field(..., examples=["John"])
    last_name: str = Field(..., examples=["Doe"])
    monthly_average_income: float = Field(..., examples=[1500.0])
    main_income_source: List[MainIncomeSourceEnum] = Field(
        ...,
        examples=[["salary"], ["own_business", "remittances"]]
    )
    own_bank_account: bool = Field(..., examples=[True, False])

class BankInformationSchemaRequest(BaseModel):
    bank_name: str = Field(..., examples=["Bank of America"])
    bank_account_type: str = Field(..., examples=["checking", "savings"])
    bank_account_number: str = Field(..., examples=["1234567890"])

class UserFinancialsSchema(BaseModel):
    id: UUID | None = Field(default=None, examples=["123e4567-e89b-12d3-a456-426614174000"])
    user_id: UUID = Field(..., examples=["123e4567-e89b-12d3-a456-426614174001"])
    monthly_average_income: float = Field(..., examples=[1500.0])
    main_income_sources: List[MainIncomeSourceEnum] = Field(
        ...,
        examples=[["salary"], ["own_business", "remittances"]]
    )
    own_bank_account: bool = Field(..., examples=[True, False])

    bank_name : str | None = Field(default=None, examples=["Bank of America"])
    bank_account_type : str | None = Field(default=None, examples=["checking", "savings"])
    bank_account_number : str | None = Field(default=None, examples=["1234567890"])

    created_at: datetime.datetime | None = Field(default=None, examples=["2024-06-01T12:00:00Z"])
    updated_at: datetime.datetime | None = Field(default=None, examples=["2024-06-02T12:00:00Z"])

    class Config:
        from_attributes = True
        json_encoders = {
            MainIncomeSourceEnum: lambda v: v.value,
        }

class UserFinancialsSchemaResponse(BaseResponse):
    data: UserFinancialsSchema
