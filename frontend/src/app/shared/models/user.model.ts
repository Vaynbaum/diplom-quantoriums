import { GroupModel } from './group.model';
import { MaterialModel } from './material.model';
import { ProjectLinkModel } from './project.model';
import { QuantoriumModel, QuantumModel } from './quantorium.model';

export class AdminModel {
  constructor(public user_id: number) {}
}
export class RepresentativeModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public quantorium_id: number,
    public quantorium: QuantoriumModel
  ) {}
}

export class UserDBModel {
  constructor(
    public id: 0,
    public firstname: string,
    public lastname: string,
    public email: string,
    public img: object,
    public created_at: Date | string,
    public role_id: 0
  ) {}
}

export class RepresentativeWithUserModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public quantorium_id: number,
    public user: UserDBModel
  ) {}
}
export class RoleModel {
  constructor(public id: number, public name: string) {}
}

export class TeacherDBModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public quantorium_id: number,
    public quantum_id: number
  ) {}
}
export class TeacherUserModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public quantorium_id: number,
    public quantum_id: number,
    public quantum: QuantumModel,
    public user: UserDMModel
  ) {}
}
export class UserDMModel {
  constructor(
    public id: number,
    public firstname: string,
    public lastname: string,
    public email: string,
    public img: object | null,
    public created_at: Date | string,
    public role_id: number
  ) {}
}
export class TeacherQuantumModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public quantorium_id: number,
    public quantum_id: number,
    public quantum: QuantumModel
  ) {}
}
export class TeacherModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public quantorium_id: number,
    public quantum_id: number,
    public quantum: QuantumModel,
    public quantorium: QuantoriumModel,
    public materials: MaterialModel[]
  ) {}
}
export class QuantumLinksModel {
  constructor(
    public student_id: number,
    public quantum_id: number,
    public is_free: true,
    public quantum: QuantumModel
  ) {}
}

export class StudentDBModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public group_id: number,
    public quantorium_id: number
  ) {}
}
export class StudentGroupModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public group_id: number,
    public quantorium_id: number,
    public group: GroupModel
  ) {}
}
export class StudentModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public group_id: number,
    public quantorium_id: number,
    public quantum_links: QuantumLinksModel[],
    public quantorium: QuantoriumModel,
    public project_links: ProjectLinkModel[],
    public group: GroupModel
  ) {}
}
export class StudentUserModel {
  constructor(
    public user_id: number,
    public phone: string,
    public patronymic: string,
    public birthdate: Date | string,
    public group_id: number,
    public quantorium_id: number,
    public user: UserDBModel,
    public is_here: boolean = false
  ) {}
}
export class UserStudentTeacherModel {
  constructor(
    public id: number,
    public firstname: string,
    public lastname: string,
    public email: string,
    public img: object | null,
    public created_at: Date | string,
    public role_id: number,
    public teacher: TeacherQuantumModel,
    public student: StudentGroupModel
  ) {}
}
export class FullUserModel {
  constructor(
    public id: number,
    public firstname: string,
    public lastname: string,
    public email: string,
    public img: object | null,
    public created_at: Date | string,
    public role_id: number,
    public admin: AdminModel | null,
    public representative: RepresentativeModel | null,
    public teacher: TeacherModel | null,
    public student: StudentModel | null,
    public role: RoleModel | null
  ) {}
}
