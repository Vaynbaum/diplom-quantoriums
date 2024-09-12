from database.base import Base
from sqlalchemy import ForeignKey, Integer, String, Column
from sqlalchemy.orm import relationship


class StudentProjectLink(Base):
    __tablename__ = "student_project_links"
    student_id = Column(Integer, ForeignKey("students.user_id"), primary_key=True)
    project_id = Column(Integer, ForeignKey("projects.id"), primary_key=True)

    role = Column(String(255), nullable=False)
