from pydantic import BaseModel, Field
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.room import Room


class RoomSQL(sqlalchemy_to_pydantic(Room)):
    img: dict | None = None

    class Config:
        from_attributes = True


class PostRoom(BaseModel):
    name: str = Field(min_length=1)
