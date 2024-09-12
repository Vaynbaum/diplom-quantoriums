import { Observable } from 'rxjs';
import {
  FullUserModel,
  TeacherUserModel,
  UserStudentTeacherModel,
} from '../../shared/models/user.model';
import {
  GetedStudentsTeachersEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Injector, OnDestroy, OnInit } from '@angular/core';
import { profileInitialState } from '../../shared/store/profile.reducer';
import { NAME_REDUCER_PROFILE, REPRESENTATIVE_ROLE } from '../../shared/consts';
import { Store } from '@ngrx/store';
import { ScheduleModel } from '../../shared/models/schedule.model';
import { MatDialog } from '@angular/material/dialog';
import { DialogAddScheduleItemComponent } from '../dialog-add-schedule-item/dialog-add-schedule-item.component';
import { GroupModel } from '../../shared/models/group.model';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { RoomModel } from '../../shared/models/room.model';
import { FormControl, FormGroup } from '@angular/forms';
import { ImageService } from '../../shared/services/image.service';

@Component({
  selector: 'app-shedule-common',
  templateUrl: './schedule-common.component.html',
  styleUrls: ['./schedule-common.component.scss'],
})
export class ScheduleCommonComponent implements OnInit, OnDestroy {
  schedules = [
    { title: 'Понедельник', id: 0, schedules: new Array<ScheduleModel>() },
    { title: 'Вторник', id: 1, schedules: new Array<ScheduleModel>() },
    { title: 'Среда', id: 2, schedules: new Array<ScheduleModel>() },
    { title: 'Четверг', id: 3, schedules: new Array<ScheduleModel>() },
    { title: 'Пятница', id: 4, schedules: new Array<ScheduleModel>() },
    { title: 'Суббота', id: 5, schedules: new Array<ScheduleModel>() },
  ];
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  ps: any;
  groups: GroupModel[] = [];
  quantums: QuantumModel[] = [];
  rooms: RoomModel[] = [];
  teachers: UserStudentTeacherModel[] = [];

  quantumControl = new FormControl<number | null>(null);
  groupControl = new FormControl<number | null>(null);
  teacherControl = new FormControl<number | null>(null);
  form = new FormGroup({
    quantum: this.quantumControl,
    group: this.groupControl,
    teacher: this.teacherControl,
  });

  constructor(
    private quantoriumService: QuantoriumService,
    private imageService: ImageService,
    private injector: Injector,
    private store: Store<{ profile: FullUserModel }>,
    public dialog: MatDialog
  ) {}
  ngOnDestroy(): void {
    this.ps.unsubscribe();
  }

  getUser() {
    if (this.profile.representative) return this.profile.representative;
    if (this.profile.teacher) return this.profile.teacher;
    if (this.profile.student) return this.profile.student;
    return null;
  }

  ngOnInit() {
    GetedStudentsTeachersEvent.subscribe((teachers) => {
      this.teachers = teachers.res;
    });

    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
      if (this.profile.id != -1) {
        let u = this.getUser();

        this.quantoriumService
          .GetGroups(u?.quantorium_id)
          .subscribe((groups) => {
            this.groups = structuredClone(groups);
          });

        this.quantoriumService.GetTeachersStudents({
          student_or_teacher: true,
        });

        this.quantoriumService
          .GetQuantums(u?.quantorium_id)
          .subscribe((quantums) => {
            this.quantums = quantums;
          });

        this.quantoriumService.GetRooms(u?.quantorium_id).subscribe((rooms) => {
          this.rooms = rooms;
        });

        this.getSchedule(u?.quantorium_id);
      }
    });
  }

  getSchedule(quantorium_id: any) {
    let quantum = this.quantumControl.value;
    let teacher = this.teacherControl.value;
    let group = this.groupControl.value;
    let params: any = { quantorium_id: quantorium_id };
    if (quantum) params.quantum_id = quantum;
    if (group) params.group_id = group;
    if (teacher) params.teacher_id = teacher;

    this.quantoriumService.GetSchedules(params).subscribe((schedules) => {
      this.schedules.forEach((schedule) => (schedule.schedules = []));
      schedules.forEach((schedule) => {
        let tbs = (schedule.time_begin as string).split(':');
        let db = new Date();
        db.setHours(Number(tbs[0]));
        db.setMinutes(Number(tbs[1]));
        schedule.time_begin_pr = db;

        let tes = (schedule.time_end as string).split(':');
        let de = new Date();
        de.setHours(Number(tes[0]));
        de.setMinutes(Number(tes[1]));
        schedule.time_end_pr = de;

        let item = this.schedules.find((s) => s.id == schedule.dateweek);
        item?.schedules.push(schedule);
      });
    });
  }

  getFullnameTeacherInvert(teacher: UserStudentTeacherModel) {
    return `${teacher.lastname} ${teacher.firstname[0]}. ${teacher.teacher.patronymic[0]}.`;
  }

  getFullnameTeacher(teacher: TeacherUserModel) {
    return `${teacher.user.lastname} ${teacher.user.firstname[0]}. ${teacher.patronymic[0]}.`;
  }

  addScheduleItem() {
    const d = this.dialog.open(DialogAddScheduleItemComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: {
        isEdit: false,
        groups: structuredClone(this.groups),
        quantums: structuredClone(this.quantums),
        rooms: structuredClone(this.rooms),
        teachers: structuredClone(this.teachers),
      },
    });
    d.afterClosed().subscribe((res) => {
      if (res) {
        let u = this.getUser();
        this.getSchedule(u?.quantorium_id);
      }
    });
  }

  editScheduleItem(schedule: ScheduleModel) {
    if (this.isEdit()) {
      const d = this.dialog.open(DialogAddScheduleItemComponent, {
        maxWidth: '500px',
        injector: this.injector,
        width: '95vw',
        data: {
          isEdit: true,
          groups: structuredClone(this.groups),
          quantums: structuredClone(this.quantums),
          rooms: structuredClone(this.rooms),
          teachers: structuredClone(this.teachers),
          schedule: schedule,
        },
      });
      d.afterClosed().subscribe((res) => {
        if (res) {
          let u = this.getUser();
          this.getSchedule(u?.quantorium_id);
        }
      });
    }
  }

  getStyleItem() {
    if (this.isEdit()) return { cursor: 'pointer' };
    return {};
  }

  isEdit() {
    return this.profile.role_id == REPRESENTATIVE_ROLE;
  }

  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
  reset() {
    this.quantumControl.setValue(null);
    this.groupControl.setValue(null);
    this.teacherControl.setValue(null);
    this.getSchedule(this.getUser()?.quantorium_id);
  }
  onSelected() {
    this.getSchedule(this.getUser()?.quantorium_id);
  }
}
