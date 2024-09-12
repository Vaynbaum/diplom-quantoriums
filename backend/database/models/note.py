from database.base import Base
from sqlalchemy import ForeignKey, Integer, Column, Text
from sqlalchemy.orm import relationship


class Note(Base):
    __tablename__ = "notes"
    id = Column(Integer, primary_key=True)
    description = Column(Text, nullable=False)

    user_id = Column(Integer, ForeignKey("users.id"))
