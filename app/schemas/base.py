from pydantic import BaseModel, Field

class BaseResponse(BaseModel):
    success: bool = Field(
        ...,
        description="Indicates if the authentication was successful",
        examples=[True, False]
    )
    message: str = Field(
        ...,
        description="A message describing the result",
        examples=["Authentication successful", "Invalid credentials", "User not found"]
    )
