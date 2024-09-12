import random
import string

import requests

from common.exceptions import ObjectChangeException, ObjectDeleteException
from common.config import settings
from database.models.project import Project


def generate_password():
    characters = string.ascii_letters + string.digits
    password = "".join(random.choice(characters) for i in range(8))
    return password


def delete_object_file(obj: dict):
    if obj:
        res = requests.post(
            f"{settings.FILE_SHARING_URL}/delete/{obj['token']}/{obj['deleteToken']}"
        )
        if res.status_code != 200:
            raise ObjectChangeException()


async def delete_object_file_async(obj: dict):
    if obj:
        res = requests.post(
            f"{settings.FILE_SHARING_URL}/delete/{obj['token']}/{obj['deleteToken']}"
        )
        if res.status_code != 200:
            raise ObjectDeleteException()


def delete_files_from_project(project: Project):
    delete_object_file(project.img)
    if "files" in project.materials:
        for f in project.materials["files"]:
            delete_object_file(f)
