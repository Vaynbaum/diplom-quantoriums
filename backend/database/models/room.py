from database.base import Base
from sqlalchemy import ForeignKey, Integer, String, Column, Text, JSON
from sqlalchemy.orm import relationship

from database.models.schedule_item import ScheduleItem


class Room(Base):
    __tablename__ = "rooms"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
    img = Column(JSON, nullable=True)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))

    items = relationship(ScheduleItem, backref="room", cascade="all,delete")
