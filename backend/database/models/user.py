from database.base import Base
from sqlalchemy import Boolean, DateTime, ForeignKey, Integer, String, Column, JSON
from sqlalchemy.orm import relationship
from datetime import datetime

from database.models.admin import Admin
from database.models.note import Note
from database.models.representative import Representative
from database.models.role import Role
from database.models.student import Student
from database.models.teacher import Teacher


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    firstname = Column(String(255), nullable=False)
    lastname = Column(String(255), nullable=False)
    email = Column(String(320), nullable=False, unique=True)
    hashed_password = Column(String(1024), nullable=False)
    img = Column(JSON, nullable=True)
    created_at = Column(DateTime, default=datetime.now)

    role_id = Column(Integer, ForeignKey("roles.id"))

    role = relationship(Role, backref="user")
    notes = relationship(Note, backref="user", cascade="all,delete")
    admin = relationship(Admin, backref="user", uselist=False, cascade="all,delete")
    representative = relationship(
        Representative, backref="user", uselist=False, cascade="all,delete"
    )
    teacher = relationship(Teacher, backref="user", uselist=False, cascade="all,delete")
    student = relationship(Student, backref="user", uselist=False, cascade="all,delete")
