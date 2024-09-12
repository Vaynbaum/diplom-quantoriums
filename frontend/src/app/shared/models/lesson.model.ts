import { StudentUserModel } from './user.model';

export class PresenceModel {
  constructor(
    public id: number,
    public is_here: true,
    public lesson_id: number,
    public student_id: number,
    public student: StudentUserModel
  ) {}
}
export class LessonModel {
  constructor(
    public id: number,
    public date: Date | string,
    public time_begin: Date | string,
    public time_end: Date | string,
    public quantorium_id: number,
    public quantum_id: number,
    public teacher_id: number,
    public group_id: number,
    public presences: PresenceModel[]
  ) {}
}
