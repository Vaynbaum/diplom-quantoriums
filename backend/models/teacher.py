from pydantic import BaseModel
from pydantic_sqlalchemy import sqlalchemy_to_pydantic
from database.models.teacher import Teacher
from models.materials import MaterialSQL
from models.quantorium import QuantoriumSQL
from models.quantum import QuantumSQL


class TeacherSQL(sqlalchemy_to_pydantic(Teacher)):
    class Config:
        from_attributes = True


class TeacherQuantum(TeacherSQL):
    quantum: QuantumSQL

    class Config:
        from_attributes = True


class FullTeacher(TeacherQuantum):
    quantorium: QuantoriumSQL
    materials: list[MaterialSQL]


class PutTeacherQuantum(BaseModel):
    teacher_id: int
    quantum_id: int
