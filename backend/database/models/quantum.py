from database.base import Base
from sqlalchemy import ForeignKey, Integer, String, Column, Text, JSON
from sqlalchemy.orm import relationship

from database.models.lesson import Lesson
from database.models.project import Project
from database.models.schedule_item import ScheduleItem
from database.models.student_quantum_link import StudentQuantumLink
from database.models.teacher import Teacher


class Quantum(Base):
    __tablename__ = "quantums"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
    img = Column(JSON, nullable=True)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))

    quantum_links = relationship(
        StudentQuantumLink, backref="quantum", cascade="all,delete"
    )
    projects = relationship(Project, backref="quantum", cascade="all,delete")
    teachers = relationship(Teacher, backref="quantum", cascade="all,delete")
    lessons = relationship(Lesson, backref="quantum", cascade="all,delete")
    items = relationship(ScheduleItem, backref="quantum", cascade="all,delete")
