from fastapi import (
    APIRouter,
    BackgroundTasks,
    Depends,
    File,
    Query,
    Security,
    UploadFile,
)
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy.orm import Session

from common.auth import AuthService
from common.consts import *
from common.depends import get_db
from common.utils import delete_object_file, delete_object_file_async
from models.message import MessageModel
from services.file_service import ImageService
from services.quantorium_service import QuantoriumService
from services.user_service import UserService
from common.exceptions import *


router = APIRouter(tags=["Image"])

security = HTTPBearer()
quantorium_service = QuantoriumService()
auth_service = AuthService()
user_service = UserService()
image_service = ImageService()


@router.post("/", summary="Добавление файла")
async def post_file(
    file: UploadFile = File(...),
):
    try:
        return await image_service.post_file(file)
    except Exception as e:
        raise ObjectAddException()


@router.delete("/", summary="Удаление файла")
async def delete_file(file: dict):
    try:
        await delete_object_file_async(file)
        return MessageModel(message="Файл успешно удален!")
    except Exception as e:
        raise ObjectDeleteException()


@router.put("/user", summary="Обновление картинки пользователя")
def post_user(
    background_tasks: BackgroundTasks,
    file: UploadFile = File(...),
    u_id: int = Query(default=None, description="Если другому пользователю"),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [ADMINISTRATOR_ID, REPRESENTATIVE_ID]
        )
        user = image_service.get_user_by_id(db, u_id if u_id else user_id)
        if user.img:
            background_tasks.add_task(delete_object_file, user.img.copy())
        return image_service.post_object(db, user, file)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.put("/group", summary="Обновление картинки группы")
def post_group(
    background_tasks: BackgroundTasks,
    group_id: int,
    file: UploadFile = File(...),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        # token_user = user_service.role_id_prove(
        #     db, user_id, role_id, [ADMINISTRATOR_ID]
        # )
        group = image_service.get_group_by_id(db, group_id)
        if group.img:
            background_tasks.add_task(delete_object_file, group.img.copy())
        return image_service.post_object(db, group, file)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.put("/project", summary="Обновление картинки проекта")
def post_project(
    background_tasks: BackgroundTasks,
    project_id: int,
    file: UploadFile = File(...),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        # token_user = user_service.role_id_prove(
        #     db, user_id, role_id, [ADMINISTRATOR_ID]
        # )
        project = image_service.get_project_by_id(db, project_id)
        if project.img:
            background_tasks.add_task(delete_object_file, project.img.copy())
        return image_service.post_object(db, project, file)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.put("/quantorium", summary="Обновление картинки кванториума")
def post_quantorium(
    background_tasks: BackgroundTasks,
    quantorium_id: int,
    file: UploadFile = File(...),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        quantorium = image_service.get_quantorium_by_id(db, quantorium_id)
        if quantorium.img:
            background_tasks.add_task(delete_object_file, quantorium.img.copy())
        return image_service.post_object(db, quantorium, file)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.put("/quantum", summary="Обновление картинки кванториума")
def post_quantum(
    background_tasks: BackgroundTasks,
    quantum_id: int,
    file: UploadFile = File(...),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        # token_user = user_service.role_id_prove(
        #     db, user_id, role_id, [ADMINISTRATOR_ID]
        # )
        quantum = image_service.get_quantum_by_id(db, quantum_id)
        if quantum.img:
            background_tasks.add_task(delete_object_file, quantum.img.copy())
        return image_service.post_object(db, quantum, file)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.put("/room", summary="Обновление картинки кабинета")
def post_room(
    background_tasks: BackgroundTasks,
    room_id: int,
    file: UploadFile = File(...),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        # token_user = user_service.role_id_prove(
        #     db, user_id, role_id, [ADMINISTRATOR_ID]
        # )
        room = image_service.get_room_by_id(db, room_id)
        if room.img:
            background_tasks.add_task(delete_object_file, room.img.copy())
        return image_service.post_object(db, room, file)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException()


@router.post("/material", summary="Добавление материала")
def post_material(
    file: UploadFile = File(...),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [TEACHER_ID])
        return image_service.post_material(db, user_id, file)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.delete("/material", summary="Удаление материала")
def delete_material(
    background_tasks: BackgroundTasks,
    material_id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(db, user_id, role_id, [TEACHER_ID])
        material = image_service.get_material_by_id(db, material_id, user_id)
        if material.file:
            background_tasks.add_task(delete_object_file, material.file)
        return image_service.delete_material(db, material)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()
