from database.base import Base
from sqlalchemy import Boolean, ForeignKey, Integer, Column
from sqlalchemy.orm import relationship


class StudentPresence(Base):
    __tablename__ = "student_presences"
    id = Column(Integer, primary_key=True)
    is_here = Column(Boolean, default=False, nullable=False)

    lesson_id = Column(Integer, ForeignKey("lessons.id"))
    student_id = Column(Integer, ForeignKey("students.user_id"))
