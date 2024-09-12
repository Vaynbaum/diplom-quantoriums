import { GroupModel } from './group.model';
import { QuantumModel } from './quantorium.model';
import { RoomModel } from './room.model';
import { TeacherUserModel } from './user.model';

export class ScheduleModel {
  constructor(
    public id: number,
    public dateweek: number,
    public time_begin: Date | string,
    public time_end: Date | string,
    public time_begin_pr: Date | string,
    public time_end_pr: Date | string,
    public quantorium_id: number,
    public quantum_id: number,
    public teacher_id: number,
    public group_id: number,
    public room_id: number,
    public quantum: QuantumModel,
    public teacher: TeacherUserModel,
    public group: GroupModel,
    public room: RoomModel
  ) {}
}
export class FullScheduleModel {
  constructor(
    public schedule_item: ScheduleModel,
    public will_pass: boolean,
    public is_marked: boolean
  ) {}
}
