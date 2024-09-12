import {
  AddedScheduleItemEvent,
  DeletedScheduleItemEvent,
  EditedScheduleItemEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ImageService } from '../../shared/services/image.service';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { RoomModel } from '../../shared/models/room.model';
import { ScheduleModel } from '../../shared/models/schedule.model';
import { UserStudentTeacherModel } from '../../shared/models/user.model';
import { getFullname } from '../../shared/utils';
export type DialogAddScheduleItemData = {
  isEdit: boolean;
  groups: any[];
  quantums: QuantumModel[];
  rooms: RoomModel[];
  schedule: ScheduleModel | null | undefined;
  teachers: UserStudentTeacherModel[];
};
@Component({
  selector: 'app-dialog-add-schedule-item',
  templateUrl: './dialog-add-schedule-item.component.html',
  styleUrls: ['./dialog-add-schedule-item.component.scss'],
})
export class DialogAddScheduleItemComponent implements OnInit {
  dateweeks = [
    { name: 'Понедельник', id: 0 },
    { name: 'Вторник', id: 1 },
    { name: 'Среда', id: 2 },
    { name: 'Четверг', id: 3 },
    { name: 'Пятница', id: 4 },
    { name: 'Суббота', id: 5 },
  ];
  dateweekControl = new FormControl(this.data.schedule?.dateweek, [
    Validators.required,
  ]);
  quantumControl = new FormControl(this.data.schedule?.quantum_id, [
    Validators.required,
  ]);
  groupControl = new FormControl(this.data.schedule?.group_id, [
    Validators.required,
  ]);
  teacherControl = new FormControl(this.data.schedule?.teacher_id, [
    Validators.required,
  ]);
  roomControl = new FormControl(this.data.schedule?.room_id, [
    Validators.required,
  ]);
  timeBeginControl = new FormControl(this.data.schedule?.time_begin, [
    Validators.required,
  ]);
  timeEndControl = new FormControl(this.data.schedule?.time_end, [
    Validators.required,
  ]);
  form = new FormGroup({
    dateweek: this.dateweekControl,
    quantum: this.quantumControl,
    group: this.groupControl,
    teacher: this.teacherControl,
    room: this.roomControl,
    time_begin: this.timeBeginControl,
    time_end: this.timeEndControl,
  });
  groupInput = {
    label: 'Группа',
    formControl: this.groupControl,
    values: this.data.groups,
    placeholder: 'Выберите группу',
    messageError: () => {
      let e = this.groupControl?.['errors'];
      if (e?.['required']) return 'Выберите группу';
      return '';
    },
  };
  quantumInput = {
    label: 'Квантум',
    formControl: this.quantumControl,
    values: this.data.quantums,
    placeholder: 'Выберите квантум',
    messageError: () => {
      let e = this.quantumControl?.['errors'];
      if (e?.['required']) return 'Выберите квантум';
      return '';
    },
  };
  roomInput = {
    label: 'Место проведения',
    formControl: this.roomControl,
    values: this.data.rooms,
    placeholder: 'Выберите место проведения',
    messageError: () => {
      let e = this.roomControl?.['errors'];
      if (e?.['required']) return 'Выберите место проведения';
      return '';
    },
  };
  teacherInput = {
    label: 'Учитель',
    formControl: this.teacherControl,
    values: this.data.teachers,
    placeholder: 'Выберите учителя',
    messageError: () => {
      let e = this.teacherControl?.['errors'];
      if (e?.['required']) return 'Выберите учителя';
      return '';
    },
  };
  deteweekInput = {
    label: 'День недели',
    formControl: this.dateweekControl,
    values: this.dateweeks,
    placeholder: 'Выберите день недели',
    messageError: () => {
      let e = this.dateweekControl?.['errors'];
      if (e?.['required']) return 'Выберите день недели';
      return '';
    },
  };
  timeBeginInput = {
    label: 'Время начало',
    formControl: this.timeBeginControl,
    placeholder: 'Введите время начало',
    messageError: () => {
      let e = this.timeBeginControl?.['errors'];
      if (e?.['required']) return 'Введите время начало';
      return '';
    },
  };
  timeEndInput = {
    label: 'Время окончания',
    formControl: this.timeEndControl,
    placeholder: 'Введите время окончания',
    messageError: () => {
      let e = this.timeEndControl?.['errors'];
      if (e?.['required']) return 'Введите время окончания';
      return '';
    },
  };
  times = [this.timeBeginInput, this.timeEndInput];
  inps = [this.quantumInput, this.groupInput, this.roomInput];
  constructor(
    private imageService: ImageService,
    @Inject(MAT_DIALOG_DATA) public data: DialogAddScheduleItemData,
    private quantoriumService: QuantoriumService,
    public dialogRef: MatDialogRef<DialogAddScheduleItemComponent>
  ) {}

  ngOnInit() {
    if (this.data.isEdit) {
      this.quantumControl.setValue(this.data.schedule?.quantum_id);
      this.dateweekControl.setValue(this.data.schedule?.dateweek);
      this.groupControl.setValue(this.data.schedule?.group_id);
      this.teacherControl.setValue(this.data.schedule?.teacher_id);
      this.roomControl.setValue(this.data.schedule?.room_id);
      this.timeBeginControl.setValue(this.data.schedule?.time_begin);
      this.timeEndControl.setValue(this.data.schedule?.time_end);
    }

    AddedScheduleItemEvent.subscribe(() => this.dialogRef.close(true));
    EditedScheduleItemEvent.subscribe(() => this.dialogRef.close(true));
    DeletedScheduleItemEvent.subscribe(() => this.dialogRef.close(true));
  }
  compileTime(time: any) {
    let tbs = (time as string).split(':');
    let db = new Date();
    db.setHours(Number(tbs[0]));
    db.setMinutes(Number(tbs[1]));
    db.setSeconds(0);
    db.setMilliseconds(0);
    const timeString = db.toTimeString().split(' ')[0];
    const milliseconds = String(db.getMilliseconds()).padStart(3, '0');
    return `${timeString}.${milliseconds}Z`;
  }
  save() {
    const { dateweek, quantum, group, teacher, room, time_begin, time_end } =
      this.form.value;
    if (
      dateweek != null &&
      dateweek != undefined &&
      quantum &&
      group &&
      teacher &&
      room &&
      time_begin &&
      time_end
    ) {
      if (this.data.isEdit) {
        this.quantoriumService.EditScheduleItem({
          dateweek: dateweek,
          quantum_id: quantum,
          teacher_id: teacher,
          group_id: group,
          room_id: room,
          time_begin: this.compileTime(time_begin),
          time_end: this.compileTime(time_end),
          id: this.data.schedule?.id,
        });
      } else
        this.quantoriumService.AddScheduleItem({
          dateweek: dateweek,
          quantum_id: quantum,
          teacher_id: teacher,
          group_id: group,
          room_id: room,
          time_begin: this.compileTime(time_begin),
          time_end: this.compileTime(time_end),
        });
    }
  }

  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }

  getFullname(profile: UserStudentTeacherModel) {
    return getFullname(profile);
  }

  deleteItem() {
    this.quantoriumService.DeleteScheduleItem(this.data.schedule?.id);
  }
}
