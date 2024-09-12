from pydantic_sqlalchemy import sqlalchemy_to_pydantic
from pydantic import BaseModel

from database.models.representative import Representative
from models.quantorium import QuantoriumSQL


class RepresentativeSQL(sqlalchemy_to_pydantic(Representative)):
    class Config:
        from_attributes = True


class FullRepresentative(RepresentativeSQL):
    quantorium: QuantoriumSQL
