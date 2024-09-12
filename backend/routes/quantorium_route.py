from typing import List
from fastapi import APIRouter, BackgroundTasks, Depends, Query, Security
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy.orm import Session
from datetime import date

from common.auth import AuthService
from common.consts import *
from common.depends import get_db
from common.exceptions import *
from common.utils import delete_files_from_project, delete_object_file
from models.group import PostGroup, PutGroup
from models.lesson import LessonPresence, PostLesson
from models.material_teacher import MaterialTeacher
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
from services.quantorium_service import QuantoriumService
from services.user_service import UserService


router = APIRouter(tags=["Quantorium"])

security = HTTPBearer()
quantorium_service = QuantoriumService()
auth_service = AuthService()
user_service = UserService()


@router.get("/project", summary="Получение проекта", response_model=FullProject)
def get_project(
    id: int,
    db: Session = Depends(get_db),
):
    try:
        return quantorium_service.get_project(db, id)
    except Exception as e:
        raise ObjectExistException()


@router.get("/news", summary="Получение новостей", response_model=List[NewsSQL])
def get_news(
    quantorium_id: int,
    date: date = Query(default=None, description="Поиск по дате"),
    title: str = Query(default=None, description="Подстрока заголовка"),
    db: Session = Depends(get_db),
):
    try:
        return quantorium_service.get_news(db, quantorium_id, date, title)
    except Exception as e:
        raise ObjectsExistException()


@router.post("/", summary="Создание кванториума")
def post_quantorium(
    quantorium: PostQuantorium,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        user_service.role_id_prove(db, user_id, role_id, [ADMINISTRATOR_ID])
        return quantorium_service.post_quantorium(db, quantorium)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/quantum", summary="Создание квантума")
def post_quantum(
    quantum: PostQuantum,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.post_quantum(
            db, quantum, token_user.representative.quantorium_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/group", summary="Создание группы")
def post_group(
    group: PostGroup,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.post_group(
            db, group, token_user.representative.quantorium_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/news", summary="Добавление новости")
def post_news(
    news: PostNews,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.post_news(
            db, news, token_user.representative.quantorium_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.put("/news", summary="Изменение новости")
def put_news(
    background_tasks: BackgroundTasks,
    news_new: PutNews,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        news = quantorium_service.get_news_by_id(
            db, news_new.id, token_user.representative.quantorium_id
        )
        if news.img and news.img != news_new.img:
            background_tasks.add_task(delete_object_file(news.img.copy()))
        return quantorium_service.put_news(db, news, news_new)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.delete("/news", summary="Удаление новости")
def delete_news(
    background_tasks: BackgroundTasks,
    news_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        news = quantorium_service.get_news_by_id(
            db, news_id, token_user.representative.quantorium_id
        )
        if news.img:
            background_tasks.add_task(delete_object_file(news.img.copy()))
        return quantorium_service.delete_news(db, news)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()


@router.post("/room", summary="Добавление кабинета")
def post_room(
    room: PostRoom,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.post_room(
            db, room, token_user.representative.quantorium_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/quantum/student", summary="Добавление студента в квантум")
def post_quantum_student(
    quantum_student_link: PostQuantumStudent,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.post_quantum_student(
            db,
            quantum_student_link,
        )
    except (RoleException, UserException) as e:
        raise e
    except ObjectAddException as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/quantum/projects", summary="Добавление проекта")
def post_project(
    project: PostProject,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [STUDENT_ID])
        return quantorium_service.post_project(db, user_id, project)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/quantum/projects/student", summary="Добавление студента в проект")
def post_project_student(
    project_student_link: PostProjectStudent,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [STUDENT_ID])
        return quantorium_service.post_project_student(
            db, project_student_link, user_id
        )
    except (RoleException, UserException) as e:
        raise e
    except ObjectAddException as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.delete("/quantum/projects/student/", summary="Удаление студента из проекта")
def delete_project_student(
    project_id: int,
    student_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [STUDENT_ID])
        return quantorium_service.delete_project_student(
            db, project_id, student_id, token_user.id
        )
    except (RoleException, UserException) as e:
        raise e
    except ObjectDeleteException as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()


@router.get(
    "/", summary="Получение кванториумов", response_model=List[QuantoriumRepresentative]
)
def get_quantoriums(
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [ADMINISTRATOR_ID]
        )
        return quantorium_service.get_quantoriums(db)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.get(
    "/teachers_or_students",
    summary="Получение учителей/студентов кванториума",
    response_model=List[UserStudentTeacher],
)
def get_teachers_or_students(
    student_or_teacher: bool = Query(
        default=True, description="True = учитель, False = студент"
    ),
    lastname: str = Query(default=None, description="Поиск по фамилии"),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID,TEACHER_ID]
        )
        return quantorium_service.get_teachers_or_students(
            db,
            token_user,
            student_or_teacher,
            lastname,
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.post(
    "/reason",
    summary="Добавление причины (без quantorium_id во все админ, у представителя только в свой можно)",
)
def post_reason(
    reason: PostReason,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [ADMINISTRATOR_ID, REPRESENTATIVE_ID]
        )
        return quantorium_service.post_reason(db, reason, token_user)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.get("/group", summary="Получение группы", response_model=GroupStudent)
def get_group(group_id: int, db: Session = Depends(get_db)):
    try:
        return quantorium_service.get_group(db, group_id)
    except Exception as e:
        raise ObjectExistException()


@router.get(
    "/groups", summary="Получение групп", response_model=List[GroupShortStudent]
)
def get_groups(quantorium_id: int, db: Session = Depends(get_db)):
    try:
        return quantorium_service.get_groups(db, quantorium_id)
    except Exception as e:
        raise ObjectsExistException()


@router.get("/rooms", summary="Получение комнат", response_model=List[RoomSQL])
def get_rooms(quantorium_id: int, db: Session = Depends(get_db)):
    try:
        return quantorium_service.get_rooms(db, quantorium_id)
    except Exception as e:
        raise ObjectsExistException()


@router.get("/quantums", summary="Получение квантумов", response_model=List[QuantumSQL])
def get_quantums(quantorium_id: int, db: Session = Depends(get_db)):
    try:
        return quantorium_service.get_quantums(db, quantorium_id)
    except Exception as e:
        raise ObjectsExistException()


@router.put("/quantum/teacher", summary="Перевод учителя в квантум")
def put_teacher_to_quantum(
    teacher: PutTeacherQuantum,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.put_teacher_to_quantum(
            db, token_user.representative.quantorium_id, teacher
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.put("/quantum/group/student", summary="Перевод студента в другую группу")
def put_student_to_group(
    student: PutStudentGroup,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.put_student_to_group(
            db, token_user.representative.quantorium_id, student
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.delete("/quantum/group", summary="Удаление группы")
def delete_group(
    group_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.delete_group(
            db, token_user.representative.quantorium_id, group_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()


@router.delete("/quantum/student/", summary="Удаление студента из квантума")
def delete_quantum_student(
    student_id: int,
    quantum_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.delete_quantum_student(
            db, token_user.representative.quantorium_id, student_id, quantum_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()


@router.get(
    "/quantum/student/material",
    summary="Получение материалов студентом",
    response_model=List[MaterialTeacher],
)
def get_student_material(
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [STUDENT_ID])
        return quantorium_service.get_student_material(db, user_id)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.get(
    "/quantum/teacher/project",
    summary="Получение проектов учителем",
    response_model=List[ProjectTeacher],
)
def get_teacher_project(
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [TEACHER_ID])
        return quantorium_service.get_teacher_project(db, token_user)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.put("/project", summary="Изменение проекта студентом")
def put_project_by_student(
    project: PutProject,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [STUDENT_ID])
        return quantorium_service.put_project_by_student(db, user_id, project)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.delete("/project", summary="Удаление проекта студентом")
def delete_project_by_student(
    background_tasks: BackgroundTasks,
    project_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [STUDENT_ID])
        project = quantorium_service.get_project_by_id(db, user_id, project_id)
        background_tasks.add_task(delete_files_from_project, project)
        return quantorium_service.delete_project_by_student(db, project)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.post("/schedule", summary="Добавление расписания")
def post_schedule(
    schedule: PostSchedule,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.post_schedule(
            db, token_user.representative.quantorium_id, schedule
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.get(
    "/schedules", summary="Просмотр расписания", response_model=List[ScheduleFull]
)
def get_schedules(
    quantorium_id: int,
    teacher_id: int = Query(default=None),
    quantum_id: int = Query(default=None),
    group_id: int = Query(default=None),
    db: Session = Depends(get_db),
):
    try:
        return quantorium_service.get_schedules(
            db, quantorium_id, teacher_id, quantum_id, group_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.get(
    "/schedule",
    summary="Просмотр конкретного дня",
    response_model=List[ScheduleWithReason],
)
def get_schedule(
    date: date,
    teacher_id: int = Query(default=None),
    group_id: int = Query(default=None),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [TEACHER_ID, STUDENT_ID]
        )
        return quantorium_service.get_schedule(
            db, token_user, date, teacher_id, group_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.put("/schedule", summary="Изменение конкретного дня в расписании")
def put_schedule(
    schedule: PutSchedule,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.put_schedule(
            db, schedule, token_user.representative.quantorium_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.delete("/schedule", summary="Удаление конкретного дня в расписании")
def delete_schedule(
    schedule_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.delete_schedule(
            db, schedule_id, token_user.representative.quantorium_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()


@router.post("/lesson", summary="Завершение урока учителем")
def post_lesson(
    lesson: PostLesson,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [TEACHER_ID])
        return quantorium_service.post_lesson(db, lesson, token_user)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.get("/lesson", summary="Получение уроков", response_model=List[LessonPresence])
def get_lessons(
    date_begin: date,
    date_end: date,
    quantum_id: int = Query(default=None),
    group_id: int = Query(default=None),
    db: Session = Depends(get_db),
):
    try:
        return quantorium_service.get_lessons(
            db, date_begin, date_end, quantum_id, group_id
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.get("/reasons", summary="Получение причин", response_model=List[ReasonSQL])
def get_reasons(
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [ADMINISTRATOR_ID, REPRESENTATIVE_ID]
        )
        return quantorium_service.get_reasons(db, token_user)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectsExistException()


@router.delete("/reason", summary="Удаление причины")
def delete_reason(
    reason_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [ADMINISTRATOR_ID, REPRESENTATIVE_ID]
        )
        return quantorium_service.delete_reason(db, reason_id, token_user)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()


@router.put("/group", summary="Изменение группы")
def put_group(
    group: PutGroup,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        return quantorium_service.put_group(db, group, token_user)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()
