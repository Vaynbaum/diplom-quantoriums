from database.base import Base
from sqlalchemy import DateTime, ForeignKey, Integer, String, Column, Text, JSON
from sqlalchemy.orm import relationship
from datetime import datetime

from database.models.group import Group
from database.models.lesson import Lesson
from database.models.news import News
from database.models.quantum import Quantum
from database.models.reason import Reason
from database.models.representative import Representative
from database.models.room import Room
from database.models.schedule_item import ScheduleItem
from database.models.student import Student
from database.models.teacher import Teacher


class Quantorium(Base):
    __tablename__ = "quantoriums"
    id = Column(Integer, primary_key=True)
    address = Column(String(255), nullable=False)
    created_at = Column(DateTime, default=datetime.now)
    img = Column(JSON, nullable=True)

    representatives = relationship(
        Representative, backref="quantorium", cascade="all,delete"
    )
    teachers = relationship(Teacher, backref="quantorium", cascade="all,delete")
    quantums = relationship(Quantum, backref="quantorium", cascade="all,delete")
    students = relationship(Student, backref="quantorium", cascade="all,delete")
    reasons = relationship(Reason, backref="quantorium", cascade="all,delete")
    rooms = relationship(Room, backref="quantorium", cascade="all,delete")
    items = relationship(ScheduleItem, backref="quantorium", cascade="all,delete")
    groups = relationship(Group, backref="quantorium", cascade="all,delete")
    lessons = relationship(Lesson, backref="quantorium", cascade="all,delete")
    news = relationship(News, backref="quantorium", cascade="all,delete")
