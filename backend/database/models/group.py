from database.base import Base
from sqlalchemy import ForeignKey, Integer, String, Column, DateTime, JSON
from sqlalchemy.orm import relationship
from datetime import datetime

from database.models.lesson import Lesson
from database.models.schedule_item import ScheduleItem
from database.models.student import Student


class Group(Base):
    __tablename__ = "groups"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
    img = Column(JSON, nullable=True)
    created_at = Column(DateTime, default=datetime.now)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))

    lessons = relationship(Lesson, backref="group", cascade="all,delete")
    items = relationship(ScheduleItem, backref="group", cascade="all,delete")
    students = relationship(Student, backref="group", cascade="all,delete")
