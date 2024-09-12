from typing import List

from common.consts import *
from common.exceptions import *
from common.phrases import *
from database.models import *
from database.services.quantorium_db_service import QuantoriumDBService
from sqlalchemy.orm import Session
from datetime import date, datetime, time

from models.group import GroupSQL, PostGroup, PutGroup
from models.lesson import LessonPresence, LessonSQL, PostLesson
from models.material_teacher import MaterialTeacher
from models.message import MessageModel
from models.news import NewsSQL, PostNews, PutNews
from models.project import PostProject, PostProjectStudent, PutProject
from models.quantorium import PostQuantorium
from models.quantum import PostQuantum, PostQuantumStudent, QuantumSQL
from models.reason import PostReason, ReasonSQL
from models.room import PostRoom, RoomSQL
from models.schedule import PostSchedule, PutSchedule, ScheduleFull, ScheduleWithReason
from models.student import PutStudentGroup
from models.teacher import PutTeacherQuantum
from models.user import (
    FullProject,
    GroupShortStudent,
    GroupStudent,
    ProjectTeacher,
    QuantoriumRepresentative,
    UserStudentTeacher,
)


class QuantoriumService:
    def __init__(self):
        self.__db_handler = QuantoriumDBService()

    def post_quantorium(self, session: Session, quantorium: PostQuantorium):
        quantorium_db = Quantorium(address=quantorium.address)
        self.__db_handler.post_item(session, quantorium_db)
        return MessageModel(message="Кванториум успешно добавлен!")

    def post_quantum(self, session: Session, quantum: PostQuantum, quantorium_id: int):
        quantum_db = Quantum(
            name=quantum.name,
            quantorium_id=quantorium_id,
        )
        self.__db_handler.post_item(session, quantum_db)
        return MessageModel(message="Квантум успешно добавлен!")

    def post_group(self, session: Session, group: PostGroup, quantorium_id: int):
        group_db = Group(quantorium_id=quantorium_id, name=group.name)
        self.__db_handler.post_item(session, group_db)
        return MessageModel(message="Группа успешно добавлена!")

    def post_news(self, session: Session, news: PostNews, quantorium_id: int):
        news_db = News(
            title=news.title,
            description=news.description,
            quantorium_id=quantorium_id,
            img=news.img,
        )
        self.__db_handler.post_item(session, news_db)
        return MessageModel(message="Новость успешно добавлена!")

    def get_news_by_id(
        self,
        session: Session,
        news_id: int,
        user_quantorium_id: int,
    ):
        news_db = self.__db_handler.get_news_by_id(session, news_id)
        if news_db.quantorium_id != user_quantorium_id:
            raise RoleException()
        return news_db

    def put_news(self, session: Session, news_db: News, news: PutNews):
        news_db.title = news.title
        news_db.description = news.description
        news_db.img = news.img
        self.__db_handler.post_item(session, news_db)
        return MessageModel(message="Новость успешно обновлена!")

    def delete_news(self, session: Session, news: News):
        self.__db_handler.delete_item(session, news)
        return MessageModel(message="Новость успешно удалена!")

    def post_room(self, session: Session, room: PostRoom, quantorium_id: int):
        room_db = Room(name=room.name, quantorium_id=quantorium_id)
        self.__db_handler.post_item(session, room_db)
        return MessageModel(message="Кабинет успешно добавлен!")

    def post_project(self, session: Session, student_id: int, project: PostProject):
        project_db = Project(
            name=project.name,
            description=project.description,
            materials=project.materials,
            quantum_id=project.quantum_id,
            student_id=student_id,
            project_links=[
                StudentProjectLink(student_id=student_id, role=PROJECT_LEADER)
            ],
        )
        self.__db_handler.post_item(session, project_db)
        return MessageModel(message="Проект успешно добавлен!")

    def post_project_student(
        self, session: Session, project_student: PostProjectStudent, self_id: int
    ):
        self.__check_for_self_project_student(
            session, self_id, project_student.project_id
        )
        project_student_db = StudentProjectLink(
            student_id=project_student.student_id,
            role=project_student.role,
            project_id=project_student.project_id,
        )
        self.__db_handler.post_item(session, project_student_db)
        return MessageModel(message="Студент успешно добавлен в проект!")

    def post_quantum_student(
        self,
        session: Session,
        quantum_student_link: PostQuantumStudent,
    ):
        if quantum_student_link.is_free:
            self.__check_for_free_student_quantum(
                session, quantum_student_link.student_id
            )
        quantum_student_link_db = StudentQuantumLink(
            student_id=quantum_student_link.student_id,
            is_free=quantum_student_link.is_free,
            quantum_id=quantum_student_link.quantum_id,
        )
        self.__db_handler.post_item(session, quantum_student_link_db)
        return MessageModel(message="Студент успешно добавлен в квантум!")

    def get_project(self, session: Session, id: int) -> FullProject:
        project_db = self.__db_handler.get_project(session, id)
        return FullProject.from_orm(project_db)

    def get_news(
        self,
        session: Session,
        quantorium_id: int,
        date: date | None,
        title: str | None,
    ) -> List[NewsSQL]:
        datetime1, datetime2 = None, None
        if date:
            datetime1 = datetime.combine(date, time(0, 0, 0))
            datetime2 = datetime.combine(date, time(23, 59, 59))
        news_db = self.__db_handler.get_news(
            session, quantorium_id, datetime1, datetime2, title
        )
        return [NewsSQL.from_orm(n) for n in news_db]

    def get_quantoriums(self, session: Session) -> List[QuantoriumRepresentative]:
        quantoriums_db = self.__db_handler.get_quantoriums(session)
        return [QuantoriumRepresentative.from_orm(q) for q in quantoriums_db]

    def get_teachers_or_students(
        self,
        session: Session,
        token_user: User,
        student_or_teacher: bool,
        lastname: str | None,
    ) -> List[UserStudentTeacher]:
        u = token_user.representative if token_user.representative else token_user.teacher
        people = self.__db_handler.get_teachers_or_students(
            session,
            u.quantorium_id,
            student_or_teacher,
            lastname,
        )
        return [UserStudentTeacher.from_orm(p) for p in people]

    def delete_project_student(
        self, session: Session, project_id, student_id, self_id: int
    ):
        project_db = self.__db_handler.get_project_by_id(session, project_id)
        if project_db.student_id != self_id:
            raise RoleException()
        if project_db.student_id == student_id:
            raise ObjectDeleteException(
                detail="Создатель не может удалить себя из проекта"
            )
        self.__db_handler.delete_student_project_link(session, project_id, student_id)
        return MessageModel(message="Студент успешно удален из проекта")

    def post_reason(self, session: Session, reason: PostReason, token_user: User):
        if token_user.role_id == ADMINISTRATOR_ID:
            reason_db = Reason(
                date_begin=reason.date_begin,
                name=reason.name,
                date_end=reason.date_end,
                quantorium_id=reason.quantorium_id,
            )
        if token_user.role_id == REPRESENTATIVE_ID:
            reason_db = Reason(
                date_begin=reason.date_begin,
                name=reason.name,
                date_end=reason.date_end,
                quantorium_id=token_user.representative.quantorium_id,
            )
        self.__db_handler.post_item(session, reason_db)
        self.__create_news(
            session, reason.title, reason.description, None, reason.quantorium_id
        )
        return MessageModel(message="Причина успешно добавлена!")

    def __sort_stud(self, item):
        return item.user.lastname

    def get_group(self, session: Session, group_id: int) -> GroupStudent:
        group_db = self.__db_handler.get_group(session, group_id)
        group_db.students.sort(key=self.__sort_stud)
        return GroupStudent.from_orm(group_db)

    def get_groups(self, session: Session, quantorium_id: int) -> List[GroupSQL]:
        groups_db = self.__db_handler.get_groups(session, quantorium_id)
        return [GroupShortStudent.from_orm(g) for g in groups_db]

    def get_rooms(self, session: Session, quantorium_id: int) -> List[RoomSQL]:
        rooms_db = self.__db_handler.get_rooms(session, quantorium_id)
        return [RoomSQL.from_orm(r) for r in rooms_db]

    def get_quantums(self, session: Session, quantorium_id: int) -> List[QuantumSQL]:
        quantums_db = self.__db_handler.get_quantums(session, quantorium_id)
        return [QuantumSQL.from_orm(q) for q in quantums_db]

    def put_teacher_to_quantum(
        self, session: Session, quantorium_id: int, teacher: PutTeacherQuantum
    ):
        teacher_db = self.__db_handler.get_teacher_by_id(session, teacher.teacher_id)
        if quantorium_id != teacher_db.quantorium_id:
            raise RoleException()
        teacher_db.quantum_id = teacher.quantum_id
        self.__db_handler.post_item(session, teacher_db)
        return MessageModel(message="Учитель успешно перенесен в другой квантум!")

    def put_student_to_group(
        self, session: Session, quantorium_id: int, student: PutStudentGroup
    ):
        student_db = self.__db_handler.get_student_by_id(session, student.student_id)
        if quantorium_id != student_db.quantorium_id:
            raise RoleException()
        student_db.group_id = student.group_id
        self.__db_handler.post_item(session, student_db)
        return MessageModel(message="Студент успешно переведен в другую группу!")

    def delete_group(self, session: Session, quantorium_id: int, group_id: int):
        group_db = self.__db_handler.get_group_by_id(session, group_id)
        if quantorium_id != group_db.quantorium_id:
            raise RoleException()
        self.__db_handler.delete_item(session, group_db)
        return MessageModel(message="Группа успешно удалена!")

    def delete_quantum_student(
        self, session: Session, quantorium_id: int, student_id: int, quantum_id: int
    ):
        student_db = self.__db_handler.get_student_by_id(session, student_id)
        if student_db.quantorium_id != quantorium_id:
            raise RoleException()
        self.__db_handler.delete_quantum_student(session, student_id, quantum_id)
        return MessageModel(message="Студент успешно удален из квантума!")

    def get_student_material(self, session: Session, student_id: int):
        materials_db = self.__db_handler.get_student_material(session, student_id)
        return [MaterialTeacher.from_orm(m) for m in materials_db]

    def get_teacher_project(
        self, session: Session, teacher: User
    ) -> List[ProjectTeacher]:
        projects_db = self.__db_handler.get_teacher_project(session, teacher)
        return [ProjectTeacher.from_orm(p) for p in projects_db]

    def __create_news(
        self,
        session: Session,
        title: str,
        description: str | None,
        img: dict | None,
        quantorium_id: int | None,
    ):
        news_db = News(
            title=title, description=description, img=img, quantorium_id=quantorium_id
        )
        self.__db_handler.post_item(session, news_db)

    def __check_for_free_student_quantum(self, session: Session, student_id: int):
        if self.__db_handler.check_for_free_student_quantum(session, student_id):
            raise ObjectAddException(detail="Может быть только один бесплатный курс")

    def __check_for_self_project_student(
        self, session: Session, self_id: int, project_id: int
    ):
        if (
            self.__db_handler.check_for_self_project_student(
                session, project_id
            ).student_id
            != self_id
        ):
            raise ObjectAddException(
                detail="Добавлять участников может только создатель"
            )

    def put_project_by_student(
        self, session: Session, user_id: int, project: PutProject
    ):
        project_db = self.__db_handler.get_project_by_id(session, project.id)
        project_link = self.__db_handler.get_project_link(session, user_id, project.id)
        if project_link is None:
            raise RoleException()
        project_db.name = project.name
        project_db.description = project.description
        project_db.materials = project.materials
        self.__db_handler.post_item(session, project_db)
        return MessageModel(message="Проект успешно изменен!")

    def get_project_by_id(self, session: Session, user_id: int, project_id: int):
        project_db = self.__db_handler.get_project_by_id(session, project_id)
        if project_db.student_id != user_id:
            raise RoleException()
        return project_db

    def delete_project_by_student(self, session: Session, project: Project):
        self.__db_handler.delete_item(session, project)
        return MessageModel(message="Проект успешно удален!")

    def post_schedule(
        self, session: Session, quantorium_id: int, schedule: PostSchedule
    ):
        schedule_db = ScheduleItem(
            quantorium_id=quantorium_id,
            dateweek=schedule.dateweek,
            quantum_id=schedule.quantum_id,
            teacher_id=schedule.teacher_id,
            group_id=schedule.group_id,
            room_id=schedule.room_id,
            time_begin=schedule.time_begin,
            time_end=schedule.time_end,
        )
        self.__db_handler.post_item(session, schedule_db)
        return MessageModel(message="Расписание успешно обновлено!")

    def get_schedules(
        self,
        session: Session,
        quantorium_id: int,
        teacher_id: int | None,
        quantum_id: int | None,
        group_id: int | None,
    ) -> List[ScheduleFull]:
        schedules = self.__db_handler.get_schedules(
            session, quantorium_id, teacher_id, quantum_id, group_id
        )
        return [ScheduleFull.from_orm(s) for s in schedules]

    def get_schedule(
        self,
        session: Session,
        token_user: User,
        date: date,
        teacher_id: int | None,
        group_id: int | None,
    ) -> List[ScheduleWithReason]:
        if token_user.role_id == TEACHER_ID:
            quantorium_id = token_user.teacher.quantorium_id
        else:
            quantorium_id = token_user.student.quantorium_id
        schedule_db = self.__db_handler.get_schedule(
            session, date.weekday(), quantorium_id, teacher_id, group_id
        )
        schedule = [ScheduleFull.from_orm(s) for s in schedule_db]
        res = []
        for s in schedule:
            datetime_begin = datetime.combine(date, s.time_begin)
            datetime_end = datetime.combine(date, s.time_end)
            reasons_db = self.__db_handler.get_reasons(
                session, datetime_begin, datetime_end, quantorium_id
            )
            is_marked = False
            if token_user.role_id == TEACHER_ID:
                lessons_db = self.__db_handler.get_lessons_for_check(
                    session,
                    date,
                    s.quantorium_id,
                    s.quantum_id,
                    s.teacher_id,
                    s.group_id,
                    s.time_begin,
                    s.time_end,
                )
                lessons = [LessonSQL.from_orm(l) for l in lessons_db]
                if len(lessons) > 0:
                    is_marked = True
            reasons = [ReasonSQL.from_orm(r) for r in reasons_db]
            item = ScheduleWithReason(
                schedule_item=s,
                will_pass=True if len(reasons) == 0 else False,
                is_marked=is_marked,
            )
            res.append(item)
        return res

    def put_schedule(self, session: Session, schedule: PutSchedule, quantorium_id: int):
        schedule_db = self.__db_handler.get_schedule_by_id(session, schedule.id)
        if schedule_db.quantorium_id != quantorium_id:
            raise RoleException()
        schedule_db.dateweek = schedule.dateweek
        schedule_db.quantum_id = schedule.quantum_id
        schedule_db.teacher_id = schedule.teacher_id
        schedule_db.group_id = schedule.group_id
        schedule_db.room_id = schedule.room_id
        schedule_db.time_begin = schedule.time_begin
        schedule_db.time_end = schedule.time_end
        self.__db_handler.post_item(session, schedule_db)
        return MessageModel(message="Элемент расписания успешно изменен!")

    def delete_schedule(self, session: Session, schedule_id: int, quantorium_id: int):
        schedule_db = self.__db_handler.get_schedule_by_id(session, schedule_id)
        if schedule_db.quantorium_id != quantorium_id:
            raise RoleException()
        self.__db_handler.delete_item(session, schedule_db)
        return MessageModel(message="Элемент расписания успешно удален!")

    def post_lesson(self, session: Session, lesson: PostLesson, token_user: User):
        presences_db = [
            StudentPresence(is_here=p.is_here, student_id=p.student_id)
            for p in lesson.presences
        ]
        lesson_db = Lesson(
            date=lesson.date,
            time_begin=lesson.time_begin,
            time_end=lesson.time_end,
            quantorium_id=token_user.teacher.quantorium_id,
            quantum_id=token_user.teacher.quantum_id,
            teacher_id=token_user.id,
            group_id=lesson.group_id,
            presences=presences_db,
        )
        self.__db_handler.post_item(session, lesson_db)
        return MessageModel(message="Урок успешно завершен!")

    def get_lessons(
        self,
        session: Session,
        date_begin: date,
        date_end: date,
        quantum_id: int | None,
        group_id: int | None,
    ) -> List[LessonPresence]:
        lessons_db = self.__db_handler.get_lessons(
            session, date_begin, date_end, quantum_id, group_id
        )
        return [LessonPresence.from_orm(l) for l in lessons_db]

    def delete_reason(self, session: Session, reason_id: int, token_user: User):
        reason_db = self.__db_handler.get_reason_by_id(session, reason_id)
        if (
            token_user.role_id == REPRESENTATIVE_ID
            and token_user.representative.quantorium_id != reason_db.quantorium_id
        ):
            raise RoleException()
        self.__db_handler.delete_item(session, reason_db)
        return MessageModel(message="Причина успешно удалена!")

    def get_reasons(self, session: Session, token_user: User) -> List[ReasonSQL]:
        reasons_db = self.__db_handler.get_reasons_all(
            session,
            (
                token_user.representative.quantorium_id
                if token_user.role_id == REPRESENTATIVE_ID
                else None
            ),
        )
        return [ReasonSQL.from_orm(r) for r in reasons_db]

    def put_group(self, session: Session, group: PutGroup, token_user: User):
        group_db = self.__db_handler.get_group_by_id(session, group.id)
        if group_db.quantorium_id != token_user.representative.quantorium_id:
            raise RoleException()
        group_db.name = group.name
        self.__db_handler.post_item(session, group_db)
        return MessageModel(message="Группа успешно изменена!")
