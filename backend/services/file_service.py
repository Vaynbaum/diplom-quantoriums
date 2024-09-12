from fastapi import UploadFile
import requests
from database.models.education_material import EducationMaterial
from database.services.file_db_service import ImageDBService
from sqlalchemy.orm import Session

from models.message import MessageModel
from common.config import settings
from common.exceptions import *


class ImageService:
    def __init__(self):
        self.__db_handler = ImageDBService()

    def get_user_by_id(self, session: Session, user_id: int):
        return self.__db_handler.get_user_by_id(session, user_id)

    def get_group_by_id(self, session: Session, group_id: int):
        return self.__db_handler.get_group_by_id(session, group_id)

    def get_project_by_id(self, session: Session, project_id: int):
        return self.__db_handler.get_project_by_id(session, project_id)

    def get_quantorium_by_id(self, session: Session, quantorium_id: int):
        return self.__db_handler.get_quantorium_by_id(session, quantorium_id)

    def get_quantum_by_id(self, session: Session, quantum_id: int):
        return self.__db_handler.get_quantum_by_id(session, quantum_id)

    def get_room_by_id(self, session: Session, room_id: int):
        return self.__db_handler.get_room_by_id(session, room_id)

    async def post_file(self, file: UploadFile):
        files = {"file": (file.filename, file.file, file.content_type)}
        res = requests.post(f"{settings.FILE_SHARING_URL}/upload", files=files)
        r = res.json()
        if res.status_code != 200:
            raise ObjectAddException()
        return r

    async def get_object(self, obj):
        if obj.img:
            res = requests.get(f"{settings.FILE_SHARING_URL}/info/{obj.img['token']}")
            r = res.json()
            if res.status_code != 200:
                raise ObjectExistException(detail=IMAGE_GET_FAILED)
            result = r.get("downloadUrl", None)
            if result is None:
                raise ObjectExistException(detail=IMAGE_GET_FAILED)
            return result
        return MessageModel(message="Нет картинки")

    def post_material(self, session: Session, teacher_id: int, file: UploadFile):
        files = {"file": (file.filename, file.file, file.content_type)}
        res = requests.post(f"{settings.FILE_SHARING_URL}/upload", files=files)
        r = res.json()
        if res.status_code != 200:
            raise ObjectAddException()
        material_db = EducationMaterial(teacher_id=teacher_id, file=r)
        self.__db_handler.post_item(session, material_db)
        return MessageModel(message="Материал успешно добавлен")

    def post_object(self, session: Session, obj, file: UploadFile):
        files = {"file": (file.filename, file.file, file.content_type)}
        res = requests.post(f"{settings.FILE_SHARING_URL}/upload", files=files)
        r = res.json()
        if res.status_code != 200:
            raise ObjectChangeException()
        obj.img = r
        self.__db_handler.post_item(session, obj)
        return MessageModel(message=IMAGE_UPDATE_SUCCESS)

    def get_material_by_id(self, session: Session, material_id: int, teacher_id: int):
        material_db = self.__db_handler.get_material_by_id(session, material_id)
        if material_db.teacher_id != teacher_id:
            raise ObjectDeleteException()
        return material_db

    def delete_material(self, session: Session, material: EducationMaterial):
        self.__db_handler.delete_item(session, material)
        return MessageModel(message="Материал успешно удален")
