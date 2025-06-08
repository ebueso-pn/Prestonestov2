
from pydantic import BaseModel, Field
from typing import Any, Optional, Dict

class EquifaxProcessResponse(BaseModel):
    eligible: bool = Field(..., description="Whether the candidate is eligible for a loan based on Equifax data")
    message: str = Field(..., description="A message describing the result of the Equifax check")
    data: Optional[Dict[str, Any]] = Field(default=None, description="Raw Equifax data or error details")
