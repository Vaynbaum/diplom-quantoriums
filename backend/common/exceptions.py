from typing import Any, Dict
from fastapi import HTTPException
from common.phrases import *


class RoleException(HTTPException):
    def __init__(self, detail=ROLE_DENIED):
        self.status_code = 403
        self.detail = detail


class RecoveryException(HTTPException):
    def __init__(self, detail=RECOVERY_ERROR):
        self.status_code = 400
        self.detail = detail


class UserException(HTTPException):
    def __init__(self, detail=USER_NOT_EXIST):
        self.status_code = 404
        self.detail = detail


class ObjectAddException(HTTPException):
    def __init__(self, detail=OBJECT_ADD_ERROR):
        self.status_code = 400
        self.detail = detail


class ObjectChangeException(HTTPException):
    def __init__(self, detail=OBJECT_CHANGE_ERROR):
        self.status_code = 400
        self.detail = detail


class ObjectDeleteException(HTTPException):
    def __init__(self, detail=OBJECT_DELETE_ERROR):
        self.status_code = 400
        self.detail = detail


class ObjectExistException(HTTPException):
    def __init__(self, detail=OBJECT_EXIST_ERROR):
        self.status_code = 404
        self.detail = detail


class ObjectsExistException(HTTPException):
    def __init__(self, detail=OBJECTS_EXIST_ERROR):
        self.status_code = 404
        self.detail = detail
