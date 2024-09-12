import { HttpClient } from '@angular/common/http';
import { EventEmitter, Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { MessageModel } from '../models/message.model';
import { ErrorService } from './error.service';
const URL = `${environment.BACKEND_URL}/file`;
export type LoadImgGroupModel = {
  u_id: number | null | undefined;
  file: any;
};
export const LoadImgUserEvent = new EventEmitter<LoadImgGroupModel>();
export const LoadedImgUserEvent = new EventEmitter<MessageModel>();

export const LoadImgQuantoriumEvent = new EventEmitter<LoadImgGroupModel>();
export const LoadedImgQuantoriumEvent = new EventEmitter<MessageModel>();

export const LoadImgQuantumEvent = new EventEmitter<LoadImgGroupModel>();
export const LoadedImgQuantumEvent = new EventEmitter<MessageModel>();

export const LoadImgRoomEvent = new EventEmitter<LoadImgGroupModel>();
export const LoadedImgRoomEvent = new EventEmitter<MessageModel>();

export const LoadImgGroupEvent = new EventEmitter<LoadImgGroupModel>();
export const LoadedImgGroupEvent = new EventEmitter<MessageModel>();

export const LoadMaterialEvent = new EventEmitter<any>();
export const LoadedMaterialEvent = new EventEmitter<MessageModel>();

export const DeleteMaterialEvent = new EventEmitter<number>();
export const DeletedMaterialEvent = new EventEmitter<MessageModel>();

export const LoadImgProjectEvent = new EventEmitter<LoadImgGroupModel>();
export const LoadedImgProjectEvent = new EventEmitter<MessageModel>();

@Injectable({
  providedIn: 'root',
})
export class ImageService {
  constructor(
    private httpClient: HttpClient,
    private errorService: ErrorService
  ) {
    LoadImgUserEvent.subscribe((data) => this.LoadUserImg(data));
    LoadImgQuantoriumEvent.subscribe((data) => this.LoadQuantoriumImg(data));
    LoadImgQuantumEvent.subscribe((data) => this.LoadQuantumImg(data));
    LoadImgRoomEvent.subscribe((data) => this.LoadRoomImg(data));
    LoadImgGroupEvent.subscribe((data) => this.LoadGroupImg(data));
    DeleteMaterialEvent.subscribe((data) => this.DeleteMaterial(data));
    LoadImgProjectEvent.subscribe((data) => this.LoadProjectImg(data));
    LoadMaterialEvent.subscribe((data) => this.LoadMaterial(data));
  }

  getImg(img: any | null, defaultImg: string = '/assets/images/ava.png') {
    if (img) return `${environment.IMAGE_URL}/${img.token}`;
    return defaultImg;
  }

  LoadUserImg(data: LoadImgGroupModel) {
    let params: any = {};
    if (data.u_id) params.u_id = data.u_id;
    let formData = new FormData();

    formData.append('file', data.file);
    this.httpClient
      .put<MessageModel>(`${URL}/user`, formData, {
        params: params,
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          LoadedImgUserEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, LoadImgUserEvent, data, true)
      );
  }

  LoadFile(file: any) {
    let formData = new FormData();
    formData.append('file', file);
    return this.httpClient.post<MessageModel>(`${URL}/`, formData);
  }
  DeleteFile(file: any) {
    return this.httpClient.delete<MessageModel>(`${URL}/`, { body: file });
  }

  LoadQuantoriumImg(data: LoadImgGroupModel) {
    let params: any = {};
    if (data.u_id) params.quantorium_id = data.u_id;
    let formData = new FormData();

    formData.append('file', data.file);
    this.httpClient
      .put<MessageModel>(`${URL}/quantorium`, formData, {
        params: params,
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          LoadedImgQuantoriumEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, LoadImgQuantoriumEvent, data, true)
      );
  }

  LoadRoomImg(data: LoadImgGroupModel) {
    let params: any = {};
    if (data.u_id) params.room_id = data.u_id;
    let formData = new FormData();

    formData.append('file', data.file);
    this.httpClient
      .put<MessageModel>(`${URL}/room`, formData, {
        params: params,
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          LoadedImgRoomEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, LoadImgRoomEvent, data, true)
      );
  }

  LoadGroupImg(data: LoadImgGroupModel) {
    let params: any = {};
    if (data.u_id) params.group_id = data.u_id;
    let formData = new FormData();

    formData.append('file', data.file);
    this.httpClient
      .put<MessageModel>(`${URL}/group`, formData, {
        params: params,
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          LoadedImgGroupEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, LoadImgGroupEvent, data, true)
      );
  }

  LoadQuantumImg(data: LoadImgGroupModel) {
    let params: any = {};
    if (data.u_id) params.quantum_id = data.u_id;
    let formData = new FormData();

    formData.append('file', data.file);
    this.httpClient
      .put<MessageModel>(`${URL}/quantum`, formData, {
        params: params,
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          LoadedImgQuantumEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, LoadImgQuantumEvent, data, true)
      );
  }

  LoadMaterial(file: any) {
    let formData = new FormData();
    formData.append('file', file);
    this.httpClient.post<MessageModel>(`${URL}/material`, formData).subscribe(
      (res) => {
        this.errorService.showMessage(res);
        LoadedMaterialEvent.emit(res);
      },
      (err) => this.errorService.handleError(err, LoadMaterialEvent, file, true)
    );
  }

  DeleteMaterial(material_id: number) {
    this.httpClient
      .delete<MessageModel>(`${URL}/material`, {
        params: { material_id: material_id },
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          DeletedMaterialEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(
            err,
            DeleteMaterialEvent,
            material_id,
            true
          )
      );
  }

  LoadProjectImg(data: LoadImgGroupModel) {
    let params: any = {};
    if (data.u_id) params.project_id = data.u_id;
    let formData = new FormData();

    formData.append('file', data.file);
    this.httpClient
      .put<MessageModel>(`${URL}/project`, formData, {
        params: params,
      })
      .subscribe(
        (res) => {
          this.errorService.showMessage(res);
          LoadedImgProjectEvent.emit(res);
        },
        (err) =>
          this.errorService.handleError(err, LoadImgProjectEvent, data, true)
      );
  }
}
