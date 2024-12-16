from pydantic import BaseModel

class BirthDetails(BaseModel):
    birthDate: str  # Format: YYYY-MM-DD
    birthTime: str  # Format: HH:MM
    latitude: float
    longitude: float
    timezone: str

class CompatibilityRequest(BaseModel):
    person1: BirthDetails
    person2: BirthDetails
