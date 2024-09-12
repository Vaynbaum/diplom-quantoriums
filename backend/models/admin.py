from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.admin import Admin


class AdminSQL(sqlalchemy_to_pydantic(Admin)):
    class Config:
        from_attributes = True


class FullAdmin(AdminSQL):
    pass
