import { StudentDBModel, StudentUserModel } from './user.model';

export class GroupModel {
  constructor(
    public id: number,
    public name: string,
    public img: object,
    public created_at: Date | string,
    public quantorium_id: number,
    public students: StudentDBModel[]
  ) {}
}
export class FullGroupModel {
  constructor(
    public id: number,
    public name: string,
    public img: object,
    public created_at: Date | string,
    public quantorium_id: number,
    public students: StudentUserModel[]
  ) {}
}
