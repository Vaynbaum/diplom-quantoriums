from pydantic import BaseModel, EmailStr, Field


class RecoveryModel(BaseModel):
    email: EmailStr = Field(min_length=1)
