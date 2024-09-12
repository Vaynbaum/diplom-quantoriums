from pydantic_sqlalchemy import sqlalchemy_to_pydantic
from pydantic import BaseModel, Field

from database.models.quantorium import Quantorium


class QuantoriumSQL(sqlalchemy_to_pydantic(Quantorium)):
    img: dict | None = None

    class Config:
        from_attributes = True


class PostQuantorium(BaseModel):
    address: str = Field(min_length=1)
