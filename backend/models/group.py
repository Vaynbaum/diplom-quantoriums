from pydantic import BaseModel, Field
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.group import Group


class GroupSQL(sqlalchemy_to_pydantic(Group)):
    img: dict | None = None

    class Config:
        from_attributes = True


class PostGroup(BaseModel):
    name: str = Field(min_length=1)


class PutGroup(PostGroup):
    id: int = Field(ge=1)
