import os
from dotenv import load_dotenv
from fastapi import BackgroundTasks
from jinja2 import Template

from common.mail_conf import createServer, MailMessageModel, post
from common.phrases import *
from common.consts import *
from common.config import settings


load_dotenv()
sender = os.getenv("MAIL_SENDER")
password_mail = os.getenv("MAIL_PASSWORD")
serverSMTP = createServer(sender, password_mail)


def send_register_background(user, password: str):
    html = open("common/templates/registration.html", encoding="utf-8").read()
    template = Template(html)
    if serverSMTP is not None:
        res = post(
            serverSMTP,
            sender,
            user.email,
            template.render(
                url=f"{settings.FRONTEND_URL}/auth/signin",
                firstname=user.firstname,
                lastname=user.lastname,
                password=password,
            ),
            SUBJECT_REGISTRATION,
            password_mail,
        )


def send_recovery_background(email: str, code: str):
    html = open("common/templates/reset_password.html", encoding="utf-8").read()
    template = Template(html)
    if serverSMTP is not None:
        res = post(
            serverSMTP,
            sender,
            email,
            template.render(
                url=f"{settings.FRONTEND_URL}/auth/reset?code={code}",
            ),
            SUBJECT_RECOVERY,
            password_mail,
        )
