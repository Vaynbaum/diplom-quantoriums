import os
from dotenv import load_dotenv
import jwt
from fastapi import HTTPException
from passlib.context import CryptContext
from datetime import datetime, timedelta
from common.phrases import *
from common.consts import *


class AuthService:
    hasher = CryptContext(schemes=["bcrypt"])
    load_dotenv()
    secret = os.getenv("APP_SECRET_STRING", "")

    def encode_password(self, password):
        return self.hasher.hash(password)

    def verify_password(self, password, encoded_password):
        return self.hasher.verify(password, encoded_password)

    def encode_token(self, id, role_id):
        payload = {
            "exp": datetime.utcnow() + timedelta(days=0, minutes=25),
            "iat": datetime.utcnow(),
            "scope": "access_token",
            "sub": {"id": id, "role_id": role_id},
        }
        return jwt.encode(payload, self.secret, algorithm="HS256")

    def decode_token(self, token):
        try:
            payload = jwt.decode(token, self.secret, algorithms=["HS256"])
            if payload["scope"] == "access_token":
                return payload["sub"]
            raise HTTPException(status_code=401, detail=TOKEN_INVALID_SCOPE)
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail=TOKEN_EXPIRED)
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail=TOKEN_INVALID)

    def encode_refresh_token(self, id, role_id):
        payload = {
            "exp": datetime.utcnow() + timedelta(days=5),
            "iat": datetime.utcnow(),
            "scope": "refresh_token",
            "sub": {"id": id, "role_id": role_id},
        }
        return jwt.encode(payload, self.secret, algorithm="HS256")

    def refresh_token(self, refresh_token):
        try:
            payload = jwt.decode(refresh_token, self.secret, algorithms=["HS256"])
            if payload["scope"] == "refresh_token":
                id = payload["sub"]["id"]
                role_id = payload["sub"]["role_id"]
                new_access_token = self.encode_token(id, role_id)
                new_refresh_token = self.encode_refresh_token(id, role_id)
                return new_access_token, new_refresh_token
            raise HTTPException(status_code=401, detail=REFRESH_TOKEN_INVALID_SCOPE)
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail=REFRESH_TOKEN_EXPIRED)
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail=REFRESH_TOKEN_INVALID)
