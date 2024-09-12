from typing import List
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    CORS_URL: List[str]
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str
    POSTGRES_DB: str
    POSTGRES_HOST: str
    POSTGRES_PORT: str

    APP_SECRET_STRING: str

    MAIL_SENDER: str
    MAIL_PASSWORD: str

    FRONTEND_URL: str

    FILE_SHARING_URL: str

    class Config:
        env_file = ".env"


settings = Settings()
