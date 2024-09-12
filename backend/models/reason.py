from pydantic import BaseModel, Field
from datetime import datetime, timedelta
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.reason import Reason


class ReasonSQL(sqlalchemy_to_pydantic(Reason)):
    quantorium_id: int | None = None

    class Config:
        from_attributes = True


class PostReason(BaseModel):
    name: str = Field(min_length=1)
    quantorium_id: int | None = None
    title: str = Field(min_length=1)
    description: str | None = None
    date_begin: datetime
    date_end: datetime
