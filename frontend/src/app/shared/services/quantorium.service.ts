import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { EventEmitter, Injectable } from '@angular/core';
import { NewsModel } from '../models/news.model';
import {
  QuantoriumWithRepresentativesModel,
  QuantumModel,
} from '../models/quantorium.model';
import { ErrorService } from './error.service';
import { MessageModel } from '../models/message.model';
import { FullGroupModel, GroupModel } from '../models/group.model';
import { RoomModel } from '../models/room.model';
import { UserStudentTeacherModel } from '../models/user.model';
import { FullProjectModel, ProjectStudentModel } from '../models/project.model';
import { MaterialTeacherModel } from '../models/material.model';
import { FullScheduleModel, ScheduleModel } from '../models/schedule.model';
import { ReasonModel } from '../models/reason.model';
import { LessonModel } from '../models/lesson.model';
const URL = `${environment.BACKEND_URL}/quantorium`;
export type AddLessonModel = {
  group_id: number;
  time_begin: string;
  time_end: string;
  date: string;
  presences: {
    student_id: number;
    is_here: boolean;
  }[];
};
export type AddQuantumLinkModel = {
  is_free: boolean;
  student_id: number;
  quantum_id: number;
};
export type AddNewsModel = {
  title: string;
  description: string | undefined | null;
  img: any;
};
export type EditNewsModel = {
  title: string;
  description: string | undefined | null;
  img: any;
  id: number | undefined;
};
export type GetStudentsTeachersParams = {
  student_or_teacher: boolean;
  lastname?: string;
};
export type GetedStudentsTeachers = {
  res: UserStudentTeacherModel[];
  is_teacher: boolean;
};
export type DeleteStudentQuntumParams = {
  student_id: number;
  quantum_id: number;
};
export type ChangeQuantumModel = {
  teacher_id: number;
  quantum_id: number;
};
export type ChangeGroupModel = {
  student_id: number;
  group_id: number;
};
export type DeleteProjectLinkParams = {
  project_id: number;
  student_id: number;
};
export type AddProjectLinkModel = {
  role: string;
  student_id: number;
  project_id: number;
};
export type AddScheduleItemModel = {
  dateweek: number;
  quantum_id: number;
  teacher_id: number;
  group_id: number;
  room_id: number;
  time_begin: string;
  time_end: string;
};
export type EditScheduleItemModel = {
  id: number | undefined;
  dateweek: number;
  quantum_id: number;
  teacher_id: number;
  group_id: number;
  room_id: number;
  time_begin: string;
  time_end: string;
};
export type AddProjectModel = {
  name: string;
  description: string;
  materials: object;
  quantum_id: number;
};
export type EditProjectModel = {
  id: number;
  name: string;
  description: string;
  materials: object;
};
export type GetScheduleParams = {
  date: string;
  teacher_id?: number;
  group_id?: number;
};
export type AddReasonModel = {
  name: string;
  quantorium_id?: number;
  title: string;
  description?: string | null;
  date_begin: string | null | undefined;
  date_end: string | null | undefined;
};
export type GetLessonParams = {
  date_begin: string;
  date_end: string;
  quantum_id: number;
  group_id: number;
};
export type EditGroupModel = {
  id: number;
  name: string;
};
export type GetSchedulesParams = {
  teacher_id?: number;
  group_id: number;
  quantum_id?: number;
  quantorium_id: number;
};
export const GetQuantorumsEvent = new EventEmitter();
export const GetedQuantorumsEvent = new EventEmitter<
  QuantoriumWithRepresentativesModel[]
>();

export const GetMaterialsEvent = new EventEmitter();
export const GetedMaterialsEvent = new EventEmitter<MaterialTeacherModel[]>();

export const GetProjectsEvent = new EventEmitter();
export const GetedProjectsEvent = new EventEmitter<ProjectStudentModel[]>();

export const EditNewsEvent = new EventEmitter<EditNewsModel>();
export const EditedNewsEvent = new EventEmitter<MessageModel>();

export const AddNewsEvent = new EventEmitter<AddNewsModel>();
export const AddedNewsEvent = new EventEmitter<MessageModel>();

export const AddQuantoriumEvent = new EventEmitter<string>();
export const AddedQuantoriumEvent = new EventEmitter<MessageModel>();

export const AddQuantumEvent = new EventEmitter<string>();
export const AddedQuantumEvent = new EventEmitter<MessageModel>();

export const AddGroupEvent = new EventEmitter<string>();
export const AddedGroupEvent = new EventEmitter<MessageModel>();

export const AddRoomEvent = new EventEmitter<string>();
export const AddedRoomEvent = new EventEmitter<MessageModel>();

export const GetStudentsTeachersEvent =
  new EventEmitter<GetStudentsTeachersParams>();
export const GetedStudentsTeachersEvent =
  new EventEmitter<GetedStudentsTeachers>();

export const DeleteGroupEvent = new EventEmitter<number>();
export const DeletedGroupEvent = new EventEmitter<MessageModel>();

export const ChangeQuantumEvent = new EventEmitter<ChangeQuantumModel>();
export const ChangedQuantumEvent = new EventEmitter<MessageModel>();

export const ChangeGroupEvent = new EventEmitter<ChangeGroupModel>();
export const ChangedGroupEvent = new EventEmitter<MessageModel>();

export const AddQuantumLinkEvent = new EventEmitter<AddQuantumLinkModel>();
export const AddedQuantumLinkEvent = new EventEmitter<MessageModel>();

export const DeleteNewsEvent = new EventEmitter<number>();
export const DeletedNewsEvent = new EventEmitter<MessageModel>();

export const DeleteProjectEvent = new EventEmitter<number>();
export const DeletedProjectEvent = new EventEmitter<MessageModel>();

export const DeleteStudentQuntumEvent =
  new EventEmitter<DeleteStudentQuntumParams>();
export const DeletedStudentQuntumEvent = new EventEmitter<MessageModel>();

export const AddProjectEvent = new EventEmitter<AddProjectModel>();
export const AddedProjectEvent = new EventEmitter<MessageModel>();

export const EditProjectEvent = new EventEmitter<EditProjectModel>();
export const EditedProjectEvent = new EventEmitter<MessageModel>();

export const DeleteProjectLinkEvent =
  new EventEmitter<DeleteProjectLinkParams>();
export const DeletedProjectLinkEvent = new EventEmitter<MessageModel>();

export const AddProjectLinkEvent = new EventEmitter<AddProjectLinkModel>();
export const AddedProjectLinkEvent = new EventEmitter<MessageModel>();

export const AddScheduleItemEvent = new EventEmitter<AddScheduleItemModel>();
export const AddedScheduleItemEvent = new EventEmitter<MessageModel>();

export const EditScheduleItemEvent = new EventEmitter<EditScheduleItemModel>();
export const EditedScheduleItemEvent = new EventEmitter<MessageModel>();

export const DeleteScheduleItemEvent = new EventEmitter<number>();
export const DeletedScheduleItemEvent = new EventEmitter<MessageModel>();

export const GetScheduleEvent = new EventEmitter<GetScheduleParams>();
export const GetedScheduleEvent = new EventEmitter<FullScheduleModel[]>();

export const AddLessonEvent = new EventEmitter<AddLessonModel>();
export const AddedLessonEvent = new EventEmitter<MessageModel>();

export const GetReasonEvent = new EventEmitter();
export const GetedReasonEvent = new EventEmitter<ReasonModel[]>();

export const DeleteReasonEvent = new EventEmitter<number>();
export const DeletedReasonEvent = new EventEmitter<MessageModel>();

export const AddReasonEvent = new EventEmitter<AddReasonModel>();
export const AddedReasonEvent = new EventEmitter<MessageModel>();

export const EditGroupEvent = new EventEmitter<EditGroupModel>();
export const EditedGroupEvent = new EventEmitter<MessageModel>();
@Injectable({
  providedIn: 'root',
})
export class QuantoriumService {
  constructor(
    private httpClient: HttpClient,
    private errorService: ErrorService
  ) {
    GetQuantorumsEvent.subscribe(() => this.GetQuantoriums());
    GetMaterialsEvent.subscribe(() => this.GetProjects());
    GetProjectsEvent.subscribe(() => this.GetProjects());
    EditNewsEvent.subscribe((data) => this.EditNews(data));
    AddNewsEvent.subscribe((data) => this.AddNews(data));
    AddQuantumEvent.subscribe((data) => this.AddQuantum(data));
    AddGroupEvent.subscribe((data) => this.AddGroup(data));
    AddRoomEvent.subscribe((data) => this.AddRoom(data));
    DeleteGroupEvent.subscribe((data) => this.DeleteGroup(data));
    ChangeQuantumEvent.subscribe((data) => this.ChangeQuantum(data));
    ChangeGroupEvent.subscribe((data) => this.ChangeGroup(data));
    AddQuantumLinkEvent.subscribe((data) => this.AddQuantumLink(data));
    DeleteNewsEvent.subscribe((data) => this.DeleteNews(data));
    DeleteProjectEvent.subscribe((data) => this.DeleteProject(data));
    AddProjectEvent.subscribe((data) => this.AddProject(data));
    AddQuantoriumEvent.subscribe((data) => this.AddQuantorium(data));
    DeleteProjectLinkEvent.subscribe((data) => this.DeleteProjectLink(data));
    AddProjectLinkEvent.subscribe((data) => this.AddProjectLink(data));
    EditProjectEvent.subscribe((data) => this.EditProject(data));
    AddScheduleItemEvent.subscribe((data) => this.AddScheduleItem(data));
    DeleteScheduleItemEvent.subscribe((data) => this.DeleteScheduleItem(data));
    GetScheduleEvent.subscribe((data) => this.GetSchedule(data));
    AddLessonEvent.subscribe((data) => this.AddLesson(data));
    GetReasonEvent.subscribe(() => this.GetReasons());
    DeleteReasonEvent.subscribe((data) => this.DeleteReason(data));
    AddReasonEvent.subscribe((data) => this.AddReason(data));
    EditGroupEvent.subscribe((data) => this.EditGroup(data));

    DeleteStudentQuntumEvent.subscribe((data) =>
      this.DeleteStudentQuantum(data)
    );

    GetStudentsTeachersEvent.subscribe((data) =>
      this.GetTeachersStudents(data)
    );
  }
  GetNews(quantoriumId: number, date?: string | null, title?: string) {
    let params: any = { quantorium_id: quantoriumId };
    if (date) params.date = date;
    if (title) params.title = title;
    return this.httpClient.get<NewsModel[]>(`${URL}/news`, {
      params: params,
    });
  }
  AddQuantorium(data: string) {
    this.httpClient.post<MessageModel>(`${URL}/`, { address: data }).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        AddedQuantoriumEvent.emit(res);
      },
      (err) =>
        this.errorService.handleError(err, AddQuantoriumEvent, data, true)
    );
  }

  AddGroup(data: string) {
    this.httpClient
      .post<MessageModel>(`${URL}/group`, { name: data })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          AddedGroupEvent.emit(res);
        },
        (err) => this.errorService.handleError(err, AddGroupEvent, data, true)
      );
  }

  AddRoom(data: string) {
    this.httpClient.post<MessageModel>(`${URL}/room`, { name: data }).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        AddedRoomEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, AddRoomEvent, data, true)
    );
  }

  GetQuantoriums() {
    this.httpClient
      .get<QuantoriumWithRepresentativesModel[]>(`${URL}/`)
      .subscribe(
        (res) => {
          GetedQuantorumsEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(
            err,
            GetQuantorumsEvent,
            undefined,
            true
          )
      );
  }

  AddNews(data: AddNewsModel) {
    this.httpClient.post<MessageModel>(`${URL}/news`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        AddedNewsEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, AddNewsEvent, data, true)
    );
  }
  EditNews(data: EditNewsModel) {
    this.httpClient.put<MessageModel>(`${URL}/news`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        EditedNewsEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, EditNewsEvent, data, true)
    );
  }

  AddQuantum(data: string) {
    this.httpClient
      .post<MessageModel>(`${URL}/quantum`, { name: data })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          AddedQuantumEvent.emit(res);
        },
        (err) => this.errorService.handleError(err, AddQuantumEvent, data, true)
      );
  }

  GetGroups(quantoriumId: number | undefined) {
    let params: any = { quantorium_id: quantoriumId };

    return this.httpClient.get<GroupModel[]>(`${URL}/groups`, {
      params: params,
    });
  }

  GetQuantums(quantoriumId: number | undefined) {
    let params: any = { quantorium_id: quantoriumId };

    return this.httpClient.get<QuantumModel[]>(`${URL}/quantums`, {
      params: params,
    });
  }

  GetTeachersStudents(params: GetStudentsTeachersParams) {
    this.httpClient
      .get<UserStudentTeacherModel[]>(`${URL}/teachers_or_students`, {
        params: params,
      })
      .subscribe(
        (res) =>
          GetedStudentsTeachersEvent.emit({
            is_teacher: params.student_or_teacher,
            res: res,
          }),
        (err) =>
          this.errorService.handleError(
            err,
            GetStudentsTeachersEvent,
            params,
            true
          )
      );
  }

  GetRooms(quantoriumId: number | undefined) {
    let params: any = { quantorium_id: quantoriumId };

    return this.httpClient.get<RoomModel[]>(`${URL}/rooms`, {
      params: params,
    });
  }
  DeleteGroup(group_id: number) {
    this.httpClient
      .delete<MessageModel>(`${URL}/quantum/group`, {
        params: { group_id: group_id },
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedGroupEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, DeleteGroupEvent, group_id, true)
      );
  }
  ChangeQuantum(data: ChangeQuantumModel) {
    this.httpClient.put<MessageModel>(`${URL}/quantum/teacher`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        ChangedQuantumEvent.emit(res);
      },
      (err) =>
        this.errorService.handleError(err, ChangeQuantumEvent, data, true)
    );
  }

  ChangeGroup(data: ChangeGroupModel) {
    this.httpClient
      .put<MessageModel>(`${URL}/quantum/group/student`, data)
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          ChangedGroupEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, ChangeGroupEvent, data, true)
      );
  }
  DeleteStudentQuantum(params: DeleteStudentQuntumParams) {
    this.httpClient
      .delete<MessageModel>(`${URL}/quantum/student/`, { params: params })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedStudentQuntumEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(
            err,
            DeleteStudentQuntumEvent,
            params,
            true
          )
      );
  }
  AddQuantumLink(data: AddQuantumLinkModel) {
    this.httpClient
      .post<MessageModel>(`${URL}/quantum/student`, data)
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          AddedQuantumLinkEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, AddQuantumLinkEvent, data, true)
      );
  }
  DeleteNews(news_id: number) {
    this.httpClient
      .delete<MessageModel>(`${URL}/news`, { params: { news_id: news_id } })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedNewsEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, DeleteNewsEvent, news_id, true)
      );
  }
  GetMaterials() {
    this.httpClient
      .get<MaterialTeacherModel[]>(`${URL}/quantum/student/material`)
      .subscribe(
        (res) => GetedMaterialsEvent.emit(res),
        (err) =>
          this.errorService.handleError(err, GetMaterialsEvent, undefined, true)
      );
  }

  DeleteProject(id: number) {
    this.httpClient
      .delete<MessageModel>(`${URL}/project`, {
        params: { project_id: id },
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedProjectEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, DeleteProjectEvent, id, true)
      );
  }
  AddProject(data: AddProjectModel) {
    this.httpClient
      .post<MessageModel>(`${URL}/quantum/projects`, data)
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          AddedProjectEvent.emit(res);
        },
        (err) => this.errorService.handleError(err, AddProjectEvent, data, true)
      );
  }
  EditProject(data: EditProjectModel) {
    this.httpClient.put<MessageModel>(`${URL}/project`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        EditedProjectEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, EditProjectEvent, data, true)
    );
  }
  GetProjects() {
    this.httpClient
      .get<ProjectStudentModel[]>(`${URL}/quantum/teacher/project`)
      .subscribe(
        (res) => GetedProjectsEvent.emit(res),
        (err) =>
          this.errorService.handleError(err, GetProjectsEvent, undefined, true)
      );
  }

  GetProject(id: number) {
    let params: any = { id: id };
    return this.httpClient.get<FullProjectModel>(`${URL}/project`, {
      params: params,
    });
  }

  GetGroup(id: number) {
    let params: any = { group_id: id };
    return this.httpClient.get<FullGroupModel>(`${URL}/group`, {
      params: params,
    });
  }

  DeleteProjectLink(data: DeleteProjectLinkParams) {
    this.httpClient
      .delete<MessageModel>(`${URL}/quantum/projects/student/`, {
        params: data,
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedProjectLinkEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, DeleteProjectLinkEvent, data, true)
      );
  }
  AddProjectLink(data: AddProjectLinkModel) {
    this.httpClient
      .post<MessageModel>(`${URL}/quantum/projects/student`, data)
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          AddedProjectLinkEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, AddProjectLinkEvent, data, true)
      );
  }
  GetSchedules(params: GetSchedulesParams) {
    return this.httpClient.get<ScheduleModel[]>(`${URL}/schedules`, {
      params: params,
    });
  }
  AddScheduleItem(data: AddScheduleItemModel) {
    this.httpClient.post<MessageModel>(`${URL}/schedule`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        AddedScheduleItemEvent.emit(res);
      },
      (err) =>
        this.errorService.handleError(err, AddScheduleItemEvent, data, true)
    );
  }
  EditScheduleItem(data: EditScheduleItemModel) {
    this.httpClient.put<MessageModel>(`${URL}/schedule`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        EditedScheduleItemEvent.emit(res);
      },
      (err) =>
        this.errorService.handleError(err, EditScheduleItemEvent, data, true)
    );
  }
  DeleteScheduleItem(id: any) {
    this.httpClient
      .delete<MessageModel>(`${URL}/schedule`, {
        params: { schedule_id: id },
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedScheduleItemEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, DeleteScheduleItemEvent, id, true)
      );
  }
  GetSchedule(params: GetScheduleParams) {
    this.httpClient
      .get<FullScheduleModel[]>(`${URL}/schedule`, { params: params })
      .subscribe(
        (res) => GetedScheduleEvent.emit(res),
        (err) =>
          this.errorService.handleError(err, GetScheduleEvent, params, true)
      );
  }

  AddLesson(data: AddLessonModel) {
    this.httpClient.post<MessageModel>(`${URL}/lesson`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        AddedLessonEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, AddLessonEvent, data, true)
    );
  }

  GetReasons() {
    this.httpClient.get<ReasonModel[]>(`${URL}/reasons`).subscribe(
      (res) => GetedReasonEvent.emit(res),
      (err) =>
        this.errorService.handleError(err, GetReasonEvent, undefined, true)
    );
  }
  DeleteReason(id: number) {
    this.httpClient
      .delete<MessageModel>(`${URL}/reason`, { params: { reason_id: id } })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedReasonEvent.emit(res);
        },
        (err) => this.errorService.handleError(err, DeleteReasonEvent, id, true)
      );
  }
  AddReason(data: AddReasonModel) {
    this.httpClient.post<MessageModel>(`${URL}/reason`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        AddedReasonEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, AddReasonEvent, data, true)
    );
  }
  GetLessons(params: GetLessonParams) {
    return this.httpClient.get<LessonModel[]>(`${URL}/lesson`, {
      params: params,
    });
  }
  EditGroup(data: EditGroupModel) {
    this.httpClient.put<MessageModel>(`${URL}/group`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        EditedGroupEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, EditGroupEvent, data, true)
    );
  }
}
