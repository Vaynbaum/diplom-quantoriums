from sqlalchemy import Boolean, DateTime, Integer, Column, ForeignKey, Interval, String
from sqlalchemy.orm import relationship
from database.base import Base


class Reason(Base):
    __tablename__ = "reasons"
    id = Column(Integer, primary_key=True)
    date_begin = Column(DateTime, nullable=False)
    name = Column(String(100), nullable=False)
    date_end = Column(DateTime, nullable=False)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))
