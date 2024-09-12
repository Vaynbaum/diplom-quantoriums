from sqlalchemy import Date, Integer, Column, ForeignKey, String
from sqlalchemy.orm import relationship
from database.base import Base
from database.models.education_material import EducationMaterial
from database.models.lesson import Lesson
from database.models.schedule_item import ScheduleItem


class Teacher(Base):
    __tablename__ = "teachers"
    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)
    phone = Column(String(11), nullable=False)
    patronymic = Column(String(255), nullable=False)
    birthdate = Column(Date, nullable=False)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))
    quantum_id = Column(Integer, ForeignKey("quantums.id"))

    materials = relationship(EducationMaterial, backref="teacher", cascade="all,delete")
    lessons = relationship(Lesson, backref="teacher", cascade="all,delete")
    items = relationship(ScheduleItem, backref="teacher", cascade="all,delete")