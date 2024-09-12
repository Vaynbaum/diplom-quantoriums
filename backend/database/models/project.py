from database.base import Base
from sqlalchemy import JSON, DateTime, ForeignKey, Integer, String, Column, Text, JSON
from sqlalchemy.orm import relationship
from datetime import datetime

from database.models.student_project_link import StudentProjectLink


class Project(Base):
    __tablename__ = "projects"
    id = Column(Integer, primary_key=True)
    created_at = Column(DateTime, default=datetime.now)
    img = Column(JSON, nullable=True)
    name = Column(String(255), nullable=False)
    description = Column(Text, nullable=False)
    materials = Column(JSON, nullable=False)

    quantum_id = Column(Integer, ForeignKey("quantums.id"))
    student_id = Column(Integer, ForeignKey("students.user_id"))

    project_links = relationship(
        StudentProjectLink, backref="project", cascade="all,delete"
    )
