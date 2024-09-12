from sqlalchemy import Date, Integer, Column, ForeignKey, Interval
from sqlalchemy.orm import relationship
from sqlalchemy.types import Time
from database.base import Base
from database.models.student_presence import StudentPresence


class Lesson(Base):
    __tablename__ = "lessons"
    id = Column(Integer, primary_key=True)
    date = Column(Date, nullable=False)
    time_begin = Column(Time, nullable=False)
    time_end = Column(Time, nullable=False)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))
    quantum_id = Column(Integer, ForeignKey("quantums.id"))
    teacher_id = Column(Integer, ForeignKey("teachers.user_id"))
    group_id = Column(Integer, ForeignKey("groups.id"))

    presences = relationship(StudentPresence, backref="lesson", cascade="all,delete")
