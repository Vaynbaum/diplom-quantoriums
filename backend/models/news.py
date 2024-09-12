from pydantic import BaseModel, Field
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.news import News


class NewsSQL(sqlalchemy_to_pydantic(News)):
    img: dict | None = None
    description: str | None = None
    quantorium_id: int | None = None

    class Config:
        from_attributes = True


class PostNews(BaseModel):
    title: str = Field(min_length=1)
    description: str | None = None
    img: dict | None = None


class PutNews(PostNews):
    id: int
