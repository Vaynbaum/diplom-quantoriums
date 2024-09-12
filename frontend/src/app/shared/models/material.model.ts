import { TeacherUserModel } from './user.model';

export class MaterialModel {
  constructor(
    public created_at: Date | string,
    public id: number,
    public teacher_id: number,
    public file: any
  ) {}
}
export class MaterialTeacherModel {
  constructor(
    public created_at: Date | string,
    public id: number,
    public teacher_id: number,
    public file: any,
    public teacher: TeacherUserModel
  ) {}
}
