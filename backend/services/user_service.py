import asyncio
from database.models import *
from database.services.user_db_service import UserDBService
from sqlalchemy.orm import Session

from models.message import MessageModel
from models.user import *
from common.exceptions import *
from common.consts import *


class UserService:
    def __init__(self):
        self.__db_handler = UserDBService()

    def sign_in(self, session: Session, user: UserLogin):
        check_user = self.__db_handler.get_user_by_email(session, user.email)
        return check_user

    def role_id_prove(
        self, session: Session, user_id: int, role_id: int, role_id_prove: list[int]
    ):
        if role_id not in role_id_prove:
            raise RoleException()
        user_exist = self.__db_handler.get_user_by_id(session, user_id)
        if not user_exist:
            raise UserException()
        return user_exist

    def post_representative(
        self, session: Session, repres: PostRepresentative, hashed_password: str
    ):
        repres_db = User(
            firstname=repres.firstname,
            lastname=repres.lastname,
            email=repres.email,
            hashed_password=hashed_password,
            role_id=REPRESENTATIVE_ID,
            representative=Representative(
                phone=repres.phone,
                patronymic=repres.patronymic,
                quantorium_id=repres.quantorium_id,
            ),
        )
        self.__db_handler.post_item(session, repres_db)
        return MessageModel(message="Представитель успешно добавлен!")

    def post_teacher_or_student(
        self,
        session: Session,
        person: PostStudent | PostTeacher,
        hashed_password: str,
        quantorium_id: int,
    ):
        if not (person.role_id == TEACHER_ID or person.role_id == STUDENT_ID):
            raise Exception
        person_db = User(
            firstname=person.firstname,
            lastname=person.lastname,
            email=person.email,
            hashed_password=hashed_password,
            role_id=person.role_id,
        )
        if person.role_id == TEACHER_ID:
            person_db.teacher = Teacher(
                phone=person.phone,
                patronymic=person.patronymic,
                birthdate=person.birthdate,
                quantorium_id=quantorium_id,
                quantum_id=person.quantum_id,
            )
        if person.role_id == STUDENT_ID:
            person_db.student = Student(
                phone=person.phone,
                patronymic=person.patronymic,
                birthdate=person.birthdate,
                quantorium_id=quantorium_id,
                group_id=person.group_id,
            )
        self.__db_handler.post_item(session, person_db)
        return MessageModel(message="Человек успешно добавлен!")

    def create_recovery(self, session: Session, email: str, code: str):
        user = self.__db_handler.get_user_by_email(session, email)
        if user:
            self.__db_handler.create_recovery(session, user, code)
        else:
            raise RecoveryException()

    async def delete_recovery(self, session: Session, code: str):
        await asyncio.sleep(5 * 60)
        self.__db_handler.delete_recovery(session, code)

    def change_recovery(self, session: Session, code: str, changed_password: str):
        query = session.query(Recovery).get(code)
        if query:
            user = session.query(User).get(query.user_id)
            if user:
                user.hashed_password = changed_password
                session.add(user)
                session.delete(query)
                session.commit()
                return MessageModel(message="Пароль успешно изменен")
        raise RecoveryException()

    def get_profile(self, session: Session, user_id: int, role_id: int) -> FullUser:
        user_db = self.__db_handler.get_profile(session, user_id)
        if user_db.role_id == ADMINISTRATOR_ID and role_id != ADMINISTRATOR_ID:
            raise ObjectAddException()
        return FullUser.from_orm(user_db)

    def delete_profile(self, session: Session, id: int, user: User):
        user_db = self.__db_handler.get_user_by_id(session, id)
        if (
            user_db.id != user.id
            and user_db.role_id == REPRESENTATIVE_ID
            and user.role_id == REPRESENTATIVE_ID
        ):
            raise RoleException()
        self.__db_handler.delete_item(session, user_db)
        return MessageModel(message="Пользователь успешно удален!")

    def put_profile(
        self,
        session: Session,
        repr: User,
        person: PutUser,
    ):
        if person.id is None:
            repr.firstname = person.firstname
            repr.lastname = person.lastname
            repr.email = person.email
            repr.representative.phone = person.phone
            repr.representative.patronymic = person.patronymic
            self.__db_handler.post_item(session, repr)
        else:
            user_db = self.__db_handler.get_user_by_id(session, person.id)
            user_db.firstname = person.firstname
            user_db.lastname = person.lastname
            user_db.email = person.email
            if (
                user_db.role_id == TEACHER_ID
                and repr.representative.quantorium_id == user_db.teacher.quantorium_id
            ):
                user_db.teacher.phone = person.phone
                user_db.teacher.patronymic = person.patronymic
                user_db.teacher.birthdate = person.birthdate
            elif (
                user_db.role_id == STUDENT_ID
                and repr.representative.quantorium_id == user_db.student.quantorium_id
            ):
                user_db.student.phone = person.phone
                user_db.student.patronymic = person.patronymic
                user_db.student.birthdate = person.birthdate
            else:
                raise RoleException()
            self.__db_handler.post_item(session, user_db)
        return MessageModel(message="Пользователь успешно обновлен!")
