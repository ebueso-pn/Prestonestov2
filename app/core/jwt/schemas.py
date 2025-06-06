from typing import Optional
from pydantic import BaseModel

class TokenData(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"

class TokenPayload(BaseModel):
    sub: Optional[str] = None
    exp: Optional[int] = None
    token_type: Optional[str] = None
