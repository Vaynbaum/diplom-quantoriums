from sqlalchemy import Date, Integer, Column, ForeignKey, String
from sqlalchemy.orm import relationship
from database.base import Base
from database.models.project import Project
from database.models.student_presence import StudentPresence
from database.models.student_project_link import StudentProjectLink
from database.models.student_quantum_link import StudentQuantumLink


class Student(Base):
    __tablename__ = "students"
    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)
    phone = Column(String(11), nullable=False)
    patronymic = Column(String(255), nullable=False)
    birthdate = Column(Date, nullable=False)

    group_id = Column(Integer, ForeignKey("groups.id"))
    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))

    projects = relationship(Project, backref="student", cascade="all,delete")
    project_links = relationship(
        StudentProjectLink, backref="student", cascade="all,delete"
    )
    quantum_links = relationship(
        StudentQuantumLink, backref="student", cascade="all,delete"
    )
    presences = relationship(StudentPresence, backref="student", cascade="all,delete")
