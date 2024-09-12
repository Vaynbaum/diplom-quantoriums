from database.base import Base
from sqlalchemy import ForeignKey, Integer, Column, Boolean
from sqlalchemy.orm import relationship


class StudentQuantumLink(Base):
    __tablename__ = "student_quantum_links"
    student_id = Column(Integer, ForeignKey("students.user_id"), primary_key=True)
    quantum_id = Column(Integer, ForeignKey("quantums.id"), primary_key=True)

    is_free = Column(Boolean, nullable=False)
