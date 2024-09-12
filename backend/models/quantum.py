from pydantic import BaseModel, Field
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.quantum import Quantum
from models.quantorium import QuantoriumSQL


class QuantumSQL(sqlalchemy_to_pydantic(Quantum)):
    img: dict | None = None

    class Config:
        from_attributes = True


class QuantumWithQuantorium(QuantumSQL):
    quantorium: QuantoriumSQL


class PostQuantum(BaseModel):
    name: str = Field(min_length=1)


class PostQuantumStudent(BaseModel):
    is_free: bool
    student_id: int = Field(ge=1)
    quantum_id: int = Field(ge=1)
