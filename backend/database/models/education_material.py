from database.base import Base
from sqlalchemy import JSON, DateTime, ForeignKey, Integer, Column, String
from sqlalchemy.orm import relationship
from datetime import datetime


class EducationMaterial(Base):
    __tablename__ = "education_materials"
    id = Column(Integer, primary_key=True)
    created_at = Column(DateTime, default=datetime.now)
    file = Column(JSON, nullable=False)

    teacher_id = Column(Integer, ForeignKey("teachers.user_id"))
