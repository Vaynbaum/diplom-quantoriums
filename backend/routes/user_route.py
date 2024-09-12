from dotenv import load_dotenv
import os

from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, Query, Security
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from common.auth import AuthService
from common.depends import get_db
from sqlalchemy.orm import Session

from common.mail import send_recovery_background, send_register_background
from models.recovery import RecoveryModel
from services.user_service import UserService
from common.phrases import *
from common.consts import *
from common.exceptions import *
from models.user import *
from common.utils import *


router = APIRouter(tags=["User"])


security = HTTPBearer()
user_service = UserService()
auth_service = AuthService()


@router.post("/signin", summary="Авторизация")
def signin(user: UserLogin, db: Session = Depends(get_db)):
    check_user = user_service.sign_in(db, user)
    if check_user is None:
        raise HTTPException(status_code=401, detail=USER_NOT_EXIST)
    if not auth_service.verify_password(user.password, check_user.hashed_password):
        raise HTTPException(status_code=401, detail=PASSWORD_INVALID)
    access_token = auth_service.encode_token(check_user.id, check_user.role_id)
    refresh_token = auth_service.encode_refresh_token(check_user.id, check_user.role_id)
    return TokenModel(access_token=access_token, refresh_token=refresh_token)


@router.get("/refresh_token", summary="Обновление токенов по токену обновления")
def refresh_token(credentials: HTTPAuthorizationCredentials = Security(security)):
    refresh_token = credentials.credentials
    new_access_token, new_refresh_token = auth_service.refresh_token(refresh_token)
    return TokenModel(access_token=new_access_token, refresh_token=new_refresh_token)


@router.get("/profile", summary="Получение профиля", response_model=FullUser)
def get_profile(
    u_id: int = Query(default=None, description="Если чужой профиль"),
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        return user_service.get_profile(db, u_id if u_id else user_id, role_id)
    except Exception as e:
        raise ObjectExistException(USER_EXIST_ERROR)


@router.post("/representative", summary="Регистрация представителя")
def post_representative(
    background_tasks: BackgroundTasks,
    repres: PostRepresentative,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        user_service.role_id_prove(db, user_id, role_id, [ADMINISTRATOR_ID])
        gen_password = generate_password()
        background_tasks.add_task(send_register_background, repres, gen_password)
        return user_service.post_representative(
            db, repres, auth_service.encode_password(gen_password)
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/teacher_or_student", summary="Регистрация преподавателя/ученика")
def post_teacher_or_student(
    background_tasks: BackgroundTasks,
    person: PostStudent | PostTeacher,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        token_user = user_service.role_id_prove(
            db, user_id, role_id, [REPRESENTATIVE_ID]
        )
        gen_password = generate_password()
        background_tasks.add_task(send_register_background, person, gen_password)
        return user_service.post_teacher_or_student(
            db,
            person,
            auth_service.encode_password(gen_password),
            token_user.representative.quantorium_id,
        )
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectAddException()


@router.post("/create_recovery", summary="Восстановление пароля")
async def create_recovery(
    email: RecoveryModel,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
):
    email = email.email
    letters = string.ascii_lowercase
    code = "".join(random.choice(letters) for _ in range(16))
    try:
        user_service.create_recovery(db, email, code)
        background_tasks.add_task(send_recovery_background, email, code)
        background_tasks.add_task(user_service.delete_recovery, db, code)
        return code
    except Exception as e:
        raise RecoveryException()


@router.put(
    "/change_password_recovery",
    summary="Изменение пароля при восстановлении",
)
def change_password_rec(recovery: ChangeRecovery, db: Session = Depends(get_db)):
    try:
        changed_password = auth_service.encode_password(recovery.password)
        return user_service.change_recovery(db, recovery.code, changed_password)
    except Exception as e:
        raise RecoveryException()


@router.delete("/", summary="Удаление пользователя")
def delete_profile(
    id: int,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    try:
        token = credentials.credentials
        user_id, role_id = auth_service.decode_token(token).values()
        user = user_service.role_id_prove(
            db, user_id, role_id, [ADMINISTRATOR_ID, REPRESENTATIVE_ID]
        )
        return user_service.delete_profile(db, id, user)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectDeleteException()


@router.put("/", summary="Изменение пользователя")
def put_profile(
    person: PutUser,
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db),
):
    token = credentials.credentials
    user_id, role_id = auth_service.decode_token(token).values()
    try:
        repr = user_service.role_id_prove(db, user_id, role_id, [REPRESENTATIVE_ID])
        return user_service.put_profile(db, repr, person)
    except (RoleException, UserException) as e:
        raise e
    except Exception as e:
        raise ObjectChangeException(
            detail="Ошибка изменения пользователя, возможно, при смене почты она уже используется"
        )
