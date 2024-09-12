from common.consts import STUDENT_ID, TEACHER_ID
from common.phrases import PROJECT_LEADER
from database.base import Base, Engine
from sqlalchemy.orm import Session, subqueryload
from sqlalchemy import or_, and_
from datetime import date, datetime, time

from database.models import *


class QuantoriumDBService:
    def __init__(self) -> None:
        Base.metadata.create_all(Engine)

    def post_item(self, session: Session, item):
        session.add(item)
        session.commit()

    def delete_item(self, session: Session, item):
        session.delete(item)
        session.commit()

    def get_project_by_id(self, session: Session, project_id: int):
        return session.query(Project).get(project_id)

    def delete_student_project_link(
        self, session: Session, project_id: int, student_id: int
    ):
        query = (
            session.query(StudentProjectLink)
            .filter(
                StudentProjectLink.project_id == project_id,
                StudentProjectLink.student_id == student_id,
            )
            .first()
        )
        self.delete_item(session, query)

    def check_for_free_student_quantum(self, session: Session, student_id: int):
        query = (
            session.query(StudentQuantumLink)
            .filter(
                StudentQuantumLink.is_free == True,
                StudentQuantumLink.student_id == student_id,
            )
            .first()
        )
        return query

    def check_for_self_project_student(self, session: Session, project_id: int):
        query = (
            session.query(StudentProjectLink)
            .filter(
                StudentProjectLink.project_id == project_id,
                StudentProjectLink.role == PROJECT_LEADER,
            )
            .first()
        )
        return query

    def get_project(self, session: Session, id: int):
        query = (
            session.query(Project)
            .options(
                subqueryload(Project.student),
                subqueryload(Project.project_links).subqueryload(
                    StudentProjectLink.student
                ),
                subqueryload(Project.quantum).subqueryload(Quantum.quantorium),
            )
            .get(id)
        )
        return query

    def get_news(
        sefl,
        session,
        quantorium_id: int,
        datetime1: datetime | None,
        datetime2: datetime | None,
        title: str | None,
    ):
        query = (
            session.query(News)
            .filter(
                or_(News.quantorium_id == quantorium_id, News.quantorium_id == None)
            )
            .order_by(News.created_at.desc())
        )
        if datetime1:
            query = query.filter(News.created_at.between(datetime1, datetime2))
        if title:
            query = query.filter(News.title.ilike(f"%{title}%"))
        return query

    def get_news_by_id(self, session: Session, news_id: int):
        query = session.query(News).get(news_id)
        return query

    def get_quantoriums(self, session: Session):
        query = session.query(Quantorium).options(
            subqueryload(Quantorium.representatives).subqueryload(Representative.user)
        )
        return query

    def get_teachers_or_students(
        self,
        session: Session,
        quantorium_id: int,
        student_or_teacher: bool,
        lastname: str | None,
    ):
        query = (
            session.query(User)
            .options(
                subqueryload(User.student).subqueryload(Student.group),
                subqueryload(User.teacher).subqueryload(Teacher.quantum),
            )
            .order_by(User.lastname)
        )
        subquery = None
        if student_or_teacher == True:
            subquery = session.query(Teacher).filter(
                Teacher.quantorium_id == quantorium_id
            )
        else:
            subquery = session.query(Student).filter(
                Student.quantorium_id == quantorium_id
            )
        query = query.join(subquery)
        if lastname:
            query = query.filter(User.lastname.ilike(f"%{lastname}%"))
        return query

    def get_group(self, session: Session, group_id: int):
        query = (
            session.query(Group)
            .options(subqueryload(Group.students).subqueryload(Student.user))
            .get(group_id)
        )
        return query

    def get_groups(self, session: Session, quantorium_id: int):
        return (
            session.query(Group)
            .filter(Group.quantorium_id == quantorium_id)
            .order_by(Group.name)
        )

    def get_rooms(self, session: Session, quantorium_id: int):
        return (
            session.query(Room)
            .filter(Room.quantorium_id == quantorium_id)
            .order_by(Room.name)
        )

    def get_quantums(self, session: Session, quantorium_id: int):
        return (
            session.query(Quantum)
            .filter(Quantum.quantorium_id == quantorium_id)
            .order_by(Quantum.name)
        )

    def get_teacher_by_id(self, session: Session, teacher_id: int):
        return session.query(Teacher).get(teacher_id)

    def get_student_by_id(self, session: Session, student_id: int):
        return session.query(Student).get(student_id)

    def get_group_by_id(self, session: Session, group_id: int):
        return session.query(Group).get(group_id)

    def delete_quantum_student(
        self, session: Session, student_id: int, quantum_id: int
    ):
        quantum_student_db = (
            session.query(StudentQuantumLink)
            .filter(
                StudentQuantumLink.student_id == student_id,
                StudentQuantumLink.quantum_id == quantum_id,
            )
            .first()
        )
        self.delete_item(session, quantum_student_db)

    def get_student_material(self, session: Session, student_id: int):
        quantums = session.query(StudentQuantumLink.quantum_id).where(
            StudentQuantumLink.student_id == student_id
        )
        teachers = session.query(Teacher.user_id).where(
            Teacher.quantum_id.in_(quantums)
        )
        query = (
            session.query(EducationMaterial)
            .options(
                subqueryload(EducationMaterial.teacher).subqueryload(Teacher.user),
                subqueryload(EducationMaterial.teacher).subqueryload(Teacher.quantum),
            )
            .where(EducationMaterial.teacher_id.in_(teachers))
            .order_by(EducationMaterial.teacher_id)
        )
        return query

    def get_teacher_project(self, session: Session, teacher: User):
        query = (
            session.query(Project)
            .options(subqueryload(Project.student).subqueryload(Student.user))
            .filter(Project.quantum_id == teacher.teacher.quantum_id)
        ).order_by(Project.student_id)
        return query

    def get_project_link(self, session: Session, user_id: int, project_id: int):
        query = (
            session.query(StudentProjectLink)
            .filter(
                StudentProjectLink.student_id == user_id,
                StudentProjectLink.project_id == project_id,
            )
            .first()
        )
        return query

    def get_schedules(
        self,
        session: Session,
        quantorium_id: int,
        teacher_id: int | None,
        quantum_id: int | None,
        group_id: int | None,
    ):
        query = (
            session.query(ScheduleItem)
            .options(
                subqueryload(ScheduleItem.quantum),
                subqueryload(ScheduleItem.room),
                subqueryload(ScheduleItem.teacher).subqueryload(Teacher.user),
                subqueryload(ScheduleItem.group),
            )
            .filter(ScheduleItem.quantorium_id == quantorium_id)
            .order_by(ScheduleItem.dateweek, ScheduleItem.time_begin)
        )
        if teacher_id:
            query = query.filter(ScheduleItem.teacher_id == teacher_id)
        if quantum_id:
            query = query.filter(ScheduleItem.quantum_id == quantum_id)
        if group_id:
            query = query.filter(ScheduleItem.group_id == group_id)
        return query

    def get_schedule(
        self,
        session: Session,
        dateweek: int,
        quantorium_id: int,
        teacher_id: int | None,
        group_id: int | None,
    ):
        query = (
            session.query(ScheduleItem)
            .options(
                subqueryload(ScheduleItem.quantum),
                subqueryload(ScheduleItem.room),
                subqueryload(ScheduleItem.teacher).subqueryload(Teacher.user),
                subqueryload(ScheduleItem.group),
            )
            .filter(
                ScheduleItem.dateweek == dateweek,
                ScheduleItem.quantorium_id == quantorium_id,
            )
        ).order_by(ScheduleItem.time_begin)
        if teacher_id:
            query = query.filter(ScheduleItem.teacher_id == teacher_id)
        if group_id:
            query = query.filter(ScheduleItem.group_id == group_id)
        return query

    def get_reasons(
        self,
        session: Session,
        date_time_begin: datetime,
        date_time_end: datetime,
        quantorium_id: int,
    ):
        query = (
            session.query(Reason)
            .filter(
                or_(
                    Reason.quantorium_id == quantorium_id,
                    Reason.quantorium_id == None,
                )
            )
            .order_by(Reason.date_begin)
        )
        query = query.filter(
            or_(
                and_(
                    Reason.date_begin < date_time_begin,
                    Reason.date_end > date_time_begin,
                ),
                and_(
                    Reason.date_begin > date_time_begin,
                    Reason.date_begin < date_time_end,
                ),
            )
        )
        return query

    def get_schedule_by_id(self, session: Session, schedule_id: int):
        query = session.query(ScheduleItem).get(schedule_id)
        return query

    def get_lessons(
        self,
        session: Session,
        date_begin: date,
        date_end: date,
        quantum_id: int | None,
        group_id: int | None,
    ):
        query = (
            session.query(Lesson)
            .options(
                subqueryload(Lesson.presences)
                .subqueryload(StudentPresence.student)
                .subqueryload(Student.user)
            )
            .order_by(Lesson.date)
        )
        query = query.filter(
            Lesson.date.between(date_begin, date_end),
        )
        if quantum_id:
            query = query.filter(Lesson.quantum_id == quantum_id)
        if group_id:
            query = query.filter(Lesson.group_id == group_id)
        return query

    def get_lessons_for_check(
        self,
        session: Session,
        date,
        quantorium_id,
        quantum_id,
        id,
        group_id,
        time_begin,
        time_end,
    ):
        query = session.query(Lesson).filter(
            Lesson.date == date,
            Lesson.quantorium_id == quantorium_id,
            Lesson.quantum_id == quantum_id,
            Lesson.teacher_id == id,
            Lesson.group_id == group_id,
            Lesson.time_begin == time_begin,
            Lesson.time_end == time_end,
        )
        return query

    def get_reason_by_id(self, session: Session, reason_id: int):
        query = session.query(Reason).get(reason_id)
        return query

    def get_reasons_all(self, session: Session, quantorium_id: int | None):
        query = session.query(Reason).order_by(Reason.date_end.desc())
        if quantorium_id:
            query = query.filter(
                or_(Reason.quantorium_id == None, Reason.quantorium_id == quantorium_id)
            )
        else:
            query = query.filter(Reason.quantorium_id == None)
        return query
