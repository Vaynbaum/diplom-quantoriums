from database.base import Base, Engine
from sqlalchemy.orm import Session, subqueryload

from database.models import *


class ImageDBService:
    def __init__(self) -> None:
        Base.metadata.create_all(Engine)

    def post_item(self, session: Session, item):
        session.add(item)
        session.commit()

    def delete_item(self, session: Session, item):
        session.delete(item)
        session.commit()

    def get_user_by_id(self, session: Session, user_id: int):
        return session.query(User).get(user_id)

    def get_group_by_id(self, session: Session, group_id: int):
        return session.query(Group).get(group_id)

    def get_project_by_id(self, session: Session, project_id: int):
        return session.query(Project).get(project_id)

    def get_quantorium_by_id(self, session: Session, quantorium_id: int):
        return session.query(Quantorium).get(quantorium_id)

    def get_quantum_by_id(self, session: Session, quantum_id: int):
        return session.query(Quantum).get(quantum_id)

    def get_room_by_id(self, session: Session, room_id: int):
        return session.query(Room).get(room_id)

    def get_material_by_id(self, session: Session, material_id: int):
        return session.query(EducationMaterial).get(material_id)
