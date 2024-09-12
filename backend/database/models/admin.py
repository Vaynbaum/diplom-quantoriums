from sqlalchemy import Integer, Column, ForeignKey
from sqlalchemy.orm import relationship
from database.base import Base


class Admin(Base):
    __tablename__ = "admins"
    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)


