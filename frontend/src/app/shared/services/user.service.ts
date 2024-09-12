import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { EventEmitter, Injectable } from '@angular/core';
import { ME } from '../consts';
import { ErrorService } from './error.service';
import { FullUserModel } from '../models/user.model';
import { Store } from '@ngrx/store';
import { loadProfileSuccess } from '../store/profile.actions';
import { MessageModel } from '../models/message.model';
export type EditUserModel = {
  id: number | null;
  firstname: string;
  lastname: string;
  email: string;
  phone: string;
  patronymic: string;
  birthdate: string | null;
};
export type AddRepresentativeModel = {
  firstname: string;
  lastname: string;
  email: string;
  phone: string;
  patronymic: string;
  quantorium_id: number;
};
export type AddTeacherModel = {
  firstname: string;
  lastname: string;
  email: string;
  phone: string;
  patronymic: string;
  birthdate: string;
  quantum_id: number;
  role_id: number;
};
export type AddStudentModel = {
  firstname: string;
  lastname: string;
  email: string;
  phone: string;
  patronymic: string;
  birthdate: string;
  group_id: number;
  role_id: number;
};

const URL = `${environment.BACKEND_URL}/user`;
export const GetUserProfileEvent = new EventEmitter<string | number>();
export const GetedUserProfileEvent = new EventEmitter<FullUserModel>();

export const AddRepresentativeEvent =
  new EventEmitter<AddRepresentativeModel>();
export const AddedRepresentativeEvent = new EventEmitter<MessageModel>();

export const DeleteUserEvent = new EventEmitter<number>();
export const DeletedUserEvent = new EventEmitter<MessageModel>();

export const AddTeacherEvent = new EventEmitter<AddTeacherModel>();
export const AddedTeacherEvent = new EventEmitter<MessageModel>();

export const AddStudentEvent = new EventEmitter<AddStudentModel>();
export const AddedStudentEvent = new EventEmitter<MessageModel>();

export const EditUserEvent = new EventEmitter<EditUserModel>();
export const EditedUserEvent = new EventEmitter<MessageModel>();
@Injectable({ providedIn: 'root' })
export class UserService {
  constructor(
    private httpClient: HttpClient,
    private store: Store,
    private errorService: ErrorService
  ) {
    GetUserProfileEvent.subscribe((id) => this.GetUserProfile(id));
    AddRepresentativeEvent.subscribe((data) => this.AddRepresentative(data));
    DeleteUserEvent.subscribe((data) => this.DeleteUser(data));
    AddTeacherEvent.subscribe((data) => this.AddTeacher(data));
    AddStudentEvent.subscribe((data) => this.AddStudent(data));
    EditUserEvent.subscribe((data) => this.EditUser(data));
  }
  AddRepresentative(data: AddRepresentativeModel) {
    this.httpClient.post<MessageModel>(`${URL}/representative`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        AddedRepresentativeEvent.emit(res);
      },
      (err) =>
        this.errorService.handleError(err, AddRepresentativeEvent, data, true)
    );
  }
  AddStudent(data: AddStudentModel) {
    this.httpClient
      .post<MessageModel>(`${URL}/teacher_or_student`, data)
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          AddedStudentEvent.emit(res);
        },
        (err) => this.errorService.handleError(err, AddStudentEvent, data, true)
      );
  }
  AddTeacher(data: AddTeacherModel) {
    this.httpClient
      .post<MessageModel>(`${URL}/teacher_or_student`, data)
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          AddedTeacherEvent.emit(res);
        },
        (err) => this.errorService.handleError(err, AddTeacherEvent, data, true)
      );
  }
  DeleteUser(id: number) {
    let params: any = { id: id };

    this.httpClient
      .delete<MessageModel>(`${URL}/`, { params: params })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedUserEvent.emit(res);
        },
        (err) => this.errorService.handleError(err, DeleteUserEvent, id, true)
      );
  }

  GetUserProfile(id?: string | number) {
    let params: any = {};
    if (id && id != ME) params.u_id = id;
    this.httpClient
      .get<FullUserModel>(`${URL}/profile`, { params: params })
      .subscribe(
        (res) => {
          if (id == ME || id == undefined)
            this.store.dispatch(loadProfileSuccess({ profile: res }));
          GetedUserProfileEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, GetUserProfileEvent, id, true)
      );
  }

  EditUser(data: EditUserModel) {
    this.httpClient.put<MessageModel>(`${URL}/`, data).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        EditedUserEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, EditUserEvent, data, true)
    );
  }

}
