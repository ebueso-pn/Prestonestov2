from pydantic import BaseModel, Field
from typing import Optional
import uuid

from app.db.models.user_location import HousingType

class UserLocationBase(BaseModel):
    user_id: uuid.UUID = Field(..., description="User ID")
    housing_type: HousingType = Field(..., description="Type of housing")
    house_and_street: str = Field(..., description="House and street address")
    description: Optional[str] = Field(None, description="Additional description")
    neighborhood: str = Field(..., description="Neighborhood")
    city: str = Field(..., description="City")
    department: str = Field(..., description="Department")

class UserLocationCreate(BaseModel):
    housing_type: HousingType = Field(..., description="Type of housing")
    house_and_street: str = Field(..., description="House and street address")
    description: Optional[str] = Field(None, description="Additional description")
    neighborhood: str = Field(..., description="Neighborhood")
    city: str = Field(..., description="City")
    department: str = Field(..., description="Department")

class UserLocationUpdate(BaseModel):
    housing_type: Optional[HousingType] = Field(None, description="Type of housing")
    house_and_street: Optional[str] = Field(None, description="House and street address")
    description: Optional[str] = Field(None, description="Additional description")
    neighborhood: Optional[str] = Field(None, description="Neighborhood")
    city: Optional[str] = Field(None, description="City")
    department: Optional[str] = Field(None, description="Department")

class UserLocationInDBBase(UserLocationBase):
    id: uuid.UUID
    latitude: Optional[float] = Field(None, description="Latitude of the location")
    longitude: Optional[float] = Field(None, description="Longitude of the location")

    class Config:
        from_attributes=True

class UserLocation(UserLocationInDBBase):
    pass

class UserLocationInDB(UserLocationInDBBase):
    pass
