from sqlalchemy import Integer, Column, ForeignKey, String
from sqlalchemy.orm import relationship
from database.base import Base


class Representative(Base):
    __tablename__ = "representatives"
    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)
    phone = Column(String(30), nullable=False)
    patronymic = Column(String(255), nullable=False)

    quantorium_id = Column(Integer, ForeignKey("quantoriums.id"))
