from sqlalchemy import Integer, Column, ForeignKey, Interval
from sqlalchemy.orm import relationship
from sqlalchemy.types import Time
from database.base import Base


class ScheduleItem(Base):
    __tablename__ = "schedule_items"
    id = Column(Integer, primary_key=True)
    dateweek = Column(Integer, nullable=False)
    time_begin = Column(Time, nullable=False)
    time_end = Column(Time, nullable=False)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))
    quantum_id = Column(Integer, ForeignKey("quantums.id"))
    teacher_id = Column(Integer, ForeignKey("teachers.user_id"))
    group_id = Column(Integer, ForeignKey("groups.id"))
    room_id = Column(Integer, ForeignKey("rooms.id"))
