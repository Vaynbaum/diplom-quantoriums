from database.base import Base
from sqlalchemy import DateTime, ForeignKey, Integer, String, Column, Text, JSON
from sqlalchemy.orm import relationship
from datetime import datetime


class News(Base):
    __tablename__ = "news"
    id = Column(Integer, primary_key=True)
    title = Column(String(255), nullable=False)
    created_at = Column(DateTime, default=datetime.now)
    description = Column(Text, nullable=True)
    img = Column(JSON, nullable=True)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))
