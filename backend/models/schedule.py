from datetime import time
from pydantic_sqlalchemy import sqlalchemy_to_pydantic
from pydantic import BaseModel, Field

from database.models.schedule_item import ScheduleItem
from models.group import GroupSQL
from models.quantum import QuantumSQL
from models.room import RoomSQL
from models.user import TeacherUserNoQuantum


class ScheduleSQL(sqlalchemy_to_pydantic(ScheduleItem)):

    class Config:
        from_attributes = True


class PostSchedule(BaseModel):
    dateweek: int = Field(ge=0, le=6)
    quantum_id: int = Field(ge=1)
    teacher_id: int = Field(ge=1)
    group_id: int = Field(ge=1)
    room_id: int = Field(ge=1)
    time_begin: time
    time_end: time


class PutSchedule(PostSchedule):
    id: int


class ScheduleFull(ScheduleSQL):
    quantum: QuantumSQL
    teacher: TeacherUserNoQuantum
    group: GroupSQL
    room: RoomSQL


class ScheduleWithReason(BaseModel):
    schedule_item: ScheduleFull
    will_pass: bool
    is_marked: bool
