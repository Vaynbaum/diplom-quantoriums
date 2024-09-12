import { QuantumQuantoriumModel } from './quantorium.model';
import { StudentUserModel } from './user.model';
export class ProjectModel {
  constructor(
    public created_at: Date | string,
    public description: string,
    public id: number,
    public img: object | null,
    public materials: any,
    public name: string,
    public student_id: number,
    public quantum_id: number
  ) {}
}
export class ProjectStudentModel {
  constructor(
    public created_at: Date | string,
    public description: string,
    public id: number,
    public img: object | null,
    public materials: object,
    public name: string,
    public student_id: number,
    public quantum_id: number,
    public student: StudentUserModel
  ) {}
}
export class ProjectLinkModel {
  constructor(
    public project: ProjectModel,
    public project_id: number,
    public role: string,
    public student_id: number
  ) {}
}
export class ProjectLinkUserModel {
  constructor(
    public student: StudentUserModel,
    public project_id: number,
    public role: string,
    public student_id: number
  ) {}
}
export class FullProjectModel {
  constructor(
    public id: number,
    public created_at: Date | string,
    public img: {},
    public name: string,
    public description: string,
    public materials: any,
    public quantum_id: number,
    public student_id: number,
    public student: StudentUserModel,
    public quantum: QuantumQuantoriumModel,
    public project_links: ProjectLinkUserModel[]
  ) {}
}
