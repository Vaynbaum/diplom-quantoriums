from database.base import Base
from sqlalchemy import Integer, String, Column


class Role(Base):
    __tablename__ = "roles"
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
