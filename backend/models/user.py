from pydantic import BaseModel, EmailStr, Field, SecretStr
from datetime import date
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.user import User
from models.admin import FullAdmin
from models.group import GroupSQL
from models.project import ProjectSQL
from models.quantorium import QuantoriumSQL
from models.quantum import QuantumSQL, QuantumWithQuantorium
from models.representative import FullRepresentative, RepresentativeSQL
from models.role import RoleSQL
from models.student import FullStudent, StudentGroup, StudentSQL
from models.student_links import StudentProjectSQL
from models.teacher import FullTeacher, TeacherQuantum, TeacherSQL


class UserSQL(sqlalchemy_to_pydantic(User)):
    hashed_password: str | SecretStr = Field(..., exclude=True)
    img: dict | None = None

    class Config:
        from_attributes = True


class TokenModel(BaseModel):
    access_token: str
    refresh_token: str


class ChangeRecovery(BaseModel):
    code: str = Field(min_length=1)
    password: str = Field(min_length=5)


class UserLogin(BaseModel):
    email: EmailStr = Field(min_length=1)
    password: str = Field(min_length=5)


class PostUser(BaseModel):
    firstname: str = Field(min_length=1)
    lastname: str = Field(min_length=1)
    email: EmailStr = Field(min_length=1)


class PostRepresentative(PostUser):
    phone: str = Field(min_length=1)
    patronymic: str = Field(min_length=1)
    quantorium_id: int = Field(ge=1)


class PostTeacher(PostUser):
    phone: str = Field(min_length=1)
    patronymic: str = Field(min_length=1)
    birthdate: date
    quantum_id: int = Field(ge=1)
    role_id: int


class PostStudent(PostUser):
    phone: str = Field(min_length=1)
    patronymic: str = Field(min_length=1)
    birthdate: date
    group_id: int = Field(ge=1)
    role_id: int


class FullUser(UserSQL):
    admin: FullAdmin | None = None
    representative: FullRepresentative | None = None
    teacher: FullTeacher | None = None
    student: FullStudent | None = None
    role: RoleSQL


class StudentUser(StudentSQL):
    user: UserSQL


class RepresentativeUser(RepresentativeSQL):
    user: UserSQL


class StudentProjectWithStudent(StudentProjectSQL):
    student: StudentUser


class FullProject(ProjectSQL):
    student: StudentUser
    quantum: QuantumWithQuantorium
    project_links: list[StudentProjectWithStudent]


class QuantoriumRepresentative(QuantoriumSQL):
    representatives: list[RepresentativeUser]


class UserStudentTeacher(UserSQL):
    student: StudentGroup | None = None
    teacher: TeacherQuantum | None = None


class PutUser(BaseModel):
    id: int | None = None
    firstname: str = Field(min_length=1)
    lastname: str = Field(min_length=1)
    email: EmailStr = Field(min_length=1)
    phone: str = Field(min_length=1)
    patronymic: str = Field(min_length=1)
    birthdate: date | None = None


class GroupShortStudent(GroupSQL):
    students: list[StudentSQL]


class GroupStudent(GroupSQL):
    students: list[StudentUser]


class TeacherUser(TeacherSQL):
    user: UserSQL
    quantum: QuantumSQL


class TeacherUserNoQuantum(TeacherSQL):
    user: UserSQL


class ProjectTeacher(ProjectSQL):
    student: StudentUser
