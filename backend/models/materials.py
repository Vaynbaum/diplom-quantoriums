from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from database.models.education_material import EducationMaterial


class MaterialSQL(sqlalchemy_to_pydantic(EducationMaterial)):
    file: dict | None = None

    class Config:
        from_attributes = True

