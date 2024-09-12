from database.base import Base, Engine
from sqlalchemy.orm import Session, subqueryload

from database.models import *


class UserDBService:
    def __init__(self) -> None:
        Base.metadata.create_all(Engine)

    def post_item(self, session: Session, item):
        session.add(item)
        session.commit()

    def delete_item(self, session: Session, item):
        session.delete(item)
        session.commit()

    def get_user_by_email(self, session: Session, email: str) -> User:
        query = session.query(User)
        query = query.filter(User.email == email).first()
        return query

    def get_user_by_id(self, session: Session, user_id: int):
        query = (
            session.query(User)
            .options(
                subqueryload(User.admin),
                subqueryload(User.representative),
                subqueryload(User.teacher),
                subqueryload(User.student),
            )
            .get(user_id)
        )
        return query

    def create_recovery(self, session: Session, user: User, code: str):
        recovery = Recovery(
            code=code,
            user_id=user.id,
        )
        session.add(recovery)
        session.commit()

    def delete_recovery(self, session: Session, code: str):
        query = session.query(Recovery).get(code)
        if query:
            session.delete(query)
            session.commit()

    def get_profile(self, session: Session, user_id: int):
        query = (
            session.query(User)
            .options(
                subqueryload(User.role),
                subqueryload(User.admin),
                subqueryload(User.teacher).subqueryload(Teacher.quantum),
                subqueryload(User.teacher).subqueryload(Teacher.quantorium),
                subqueryload(User.student).subqueryload(Student.group),
                subqueryload(User.student)
                .subqueryload(Student.project_links)
                .subqueryload(StudentProjectLink.project),
                subqueryload(User.student)
                .subqueryload(Student.quantum_links)
                .subqueryload(StudentQuantumLink.quantum),
                subqueryload(User.student).subqueryload(Student.quantorium),
                subqueryload(User.representative).subqueryload(
                    Representative.quantorium
                ),
            )
            .get(user_id)
        )
        return query
