from pydantic import BaseModel, Field
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.project import Project


class ProjectSQL(sqlalchemy_to_pydantic(Project)):
    img: dict | None = None

    class Config:
        from_attributes = True


class PostProject(BaseModel):
    name: str = Field(min_length=1)
    description: str = Field(min_length=1)
    materials: dict | None = None
    quantum_id: int = Field(ge=1)


class PostProjectStudent(BaseModel):
    role: str = Field(min_length=1)
    student_id: int = Field(ge=1)
    project_id: int = Field(ge=1)


class PutProject(BaseModel):
    id: int = Field(ge=1)
    name: str = Field(min_length=1)
    description: str = Field(min_length=1)
    materials: dict
