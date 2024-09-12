from pydantic import BaseModel
from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.role import Role


class RoleSQL(sqlalchemy_to_pydantic(Role)):
    class Config:
        from_attributes = True
