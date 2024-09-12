from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import file_route, user_route, quantorium_route

from common.config import settings

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_URL,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user_route.router, prefix="/user")
app.include_router(quantorium_route.router, prefix="/quantorium")
app.include_router(file_route.router, prefix="/file")
