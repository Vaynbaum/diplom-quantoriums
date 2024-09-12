from pydantic_sqlalchemy import sqlalchemy_to_pydantic
from pydantic import BaseModel, Field
from datetime import time, date

from database.models.lesson import Lesson
from database.models.student_presence import StudentPresence
from models.user import StudentUser


class LessonSQL(sqlalchemy_to_pydantic(Lesson)):

    class Config:
        from_attributes = True


class PresenceSQL(sqlalchemy_to_pydantic(StudentPresence)):

    class Config:
        from_attributes = True


class PresenceStudent(PresenceSQL):
    student: StudentUser


class LessonPresence(LessonSQL):
    presences: list[PresenceStudent]


class PostPresence(BaseModel):
    student_id: int = Field(ge=1)
    is_here: bool


class PostLesson(BaseModel):
    group_id: int = Field(ge=1)
    time_begin: time
    time_end: time
    date: date
    presences: list[PostPresence]
