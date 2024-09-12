from pydantic import BaseModel
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.student import Student
from models.group import GroupSQL
from models.quantorium import QuantoriumSQL
from models.student_links import StudentProjectWithProject, StudentQuantumWithQuantum


class StudentSQL(sqlalchemy_to_pydantic(Student)):
    class Config:
        from_attributes = True


class StudentGroup(StudentSQL):
    group: GroupSQL

    class Config:
        from_attributes = True


class FullStudent(StudentGroup):
    quantum_links: list[StudentQuantumWithQuantum]
    quantorium: QuantoriumSQL
    project_links: list[StudentProjectWithProject]


class PutStudentGroup(BaseModel):
    student_id: int
    group_id: int
