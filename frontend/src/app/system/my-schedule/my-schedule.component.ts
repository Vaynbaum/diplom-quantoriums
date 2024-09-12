import {
  GetedScheduleEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Injector, OnDestroy, OnInit } from '@angular/core';
import {
  FullUserModel,
  TeacherUserModel,
} from '../../shared/models/user.model';
import {
  FullScheduleModel,
  ScheduleModel,
} from '../../shared/models/schedule.model';
import { formatDate } from '@angular/common';
import {
  FORMAT_DATE,
  LOCALE_RU,
  NAME_REDUCER_PROFILE,
  STUDENT_ROLE,
  TEACHER_ROLE,
} from '../../shared/consts';
import { profileInitialState } from '../../shared/store/profile.reducer';
import { Observable } from 'rxjs';
import { Store } from '@ngrx/store';
import { MatDialog } from '@angular/material/dialog';
import { DialogMarkLessonComponent } from '../dialog-mark-lesson/dialog-mark-lesson.component';

@Component({
  selector: 'app-my-shedule',
  templateUrl: './my-schedule.component.html',
  styleUrls: ['./my-schedule.component.scss'],
})
export class MyScheduleComponent implements OnInit, OnDestroy {
  day: any = new Date();
  schedules: FullScheduleModel[] = [];
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  ps: any;
  scheduleNames = new Map([
    [0, 'Понедельник'],
    [1, 'Вторник'],
    [2, 'Среда'],
    [3, 'Четверг'],
    [4, 'Пятница'],
    [5, 'Суббота'],
  ]);

  constructor(
    private quantoriumService: QuantoriumService,
    private store: Store<{ profile: FullUserModel }>,
    private injector: Injector,
    public dialog: MatDialog
  ) {}
  ngOnDestroy(): void {
    this.ps.unsubscribe();
  }

  ngOnInit() {
    GetedScheduleEvent.subscribe((schedules) => {
      this.schedules = schedules;
      this.schedules.forEach((schedule) => {
        let tbs = (schedule.schedule_item.time_begin as string).split(':');
        let db = new Date();
        db.setHours(Number(tbs[0]));
        db.setMinutes(Number(tbs[1]));
        schedule.schedule_item.time_begin_pr = db;

        let tes = (schedule.schedule_item.time_end as string).split(':');
        let de = new Date();
        de.setHours(Number(tes[0]));
        de.setMinutes(Number(tes[1]));
        schedule.schedule_item.time_end_pr = de;
      });
    });
    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
      if (this.profile.id != -1) this.getSchedule();
    });
  }
  getSchedule() {
    let b = '';
    let d = this.day instanceof Date ? this.day : this.day._d;
    if (this.day) b = formatDate(d, FORMAT_DATE, LOCALE_RU);

    if (this.profile.role_id == TEACHER_ROLE)
      this.quantoriumService.GetSchedule({
        date: b,
        teacher_id: this.profile.id,
      });
    else if (this.profile.role_id == STUDENT_ROLE)
      this.quantoriumService.GetSchedule({
        date: b,
        group_id: this.profile.student?.group_id,
      });
  }
  onDateChange(event: any) {
    this.day = event;
    this.getSchedule();
  }
  getFullnameTeacher(teacher: TeacherUserModel | undefined) {
    if (teacher)
      return `${teacher.user.lastname} ${teacher.user.firstname[0]}. ${teacher.patronymic[0]}.`;
    return '';
  }

  getDate() {
    return this.day instanceof Date ? this.day : this.day._d;
  }

  getDateweek() {
    let d = this.day instanceof Date ? this.day : this.day._d;
    let dayweek = d?.getDay() - 1;
    return this.scheduleNames.get(dayweek);
  }

  getTooltip(value: string | null | undefined) {
    if (value) return value;
    else return '';
  }

  styleCancell(schedule: FullScheduleModel) {
    let s: any = {};
    if (!schedule.will_pass)
      s = { color: 'red', 'text-decoration': 'line-through' };
    else if (this.profile.role_id == TEACHER_ROLE && !schedule.is_marked)
      s = { cursor: 'pointer' };

    return s;
  }

  markLesson(schedule: FullScheduleModel) {
    if (
      this.profile.role_id == TEACHER_ROLE &&
      !schedule.is_marked &&
      schedule.will_pass
    ) {
      let d = this.day instanceof Date ? this.day : this.day._d;
      let ref = this.dialog.open(DialogMarkLessonComponent, {
        maxWidth: '500px',
        injector: this.injector,
        width: '95vw',
        data: { schedule: schedule, date: d },
      });
      ref.afterClosed().subscribe((res) => {
        if (res) schedule.is_marked = true;
      });
    }
  }
}
