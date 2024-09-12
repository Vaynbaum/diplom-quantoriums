from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.student_project_link import StudentProjectLink
from database.models.student_quantum_link import StudentQuantumLink
from models.project import ProjectSQL
from models.quantum import QuantumSQL


class StudentProjectSQL(sqlalchemy_to_pydantic(StudentProjectLink)):
    class Config:
        from_attributes = True


class StudentQuantumSQL(sqlalchemy_to_pydantic(StudentQuantumLink)):
    class Config:
        from_attributes = True


class StudentProjectWithProject(StudentProjectSQL):
    project: ProjectSQL


class StudentQuantumWithQuantum(StudentQuantumSQL):
    quantum: QuantumSQL
