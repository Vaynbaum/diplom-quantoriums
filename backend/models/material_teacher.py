from models.materials import MaterialSQL
from models.user import TeacherUser


class MaterialTeacher(MaterialSQL):
    teacher: TeacherUser | None = None

    class Config:
        from_attributes = True
