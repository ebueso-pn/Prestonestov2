from pydantic import BaseModel
from typing import Optional, Dict, Any

class AuthResponse(BaseModel):
    """Schema for general auth operation responses"""
    success: bool
    message: str
    data: Optional[Dict[str, Any]] = None
