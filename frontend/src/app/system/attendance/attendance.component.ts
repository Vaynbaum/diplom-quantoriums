import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { GroupModel } from '../../shared/models/group.model';
import { FullUserModel } from '../../shared/models/user.model';
import { Observable } from 'rxjs';
import { profileInitialState } from '../../shared/store/profile.reducer';
import {
  FORMAT_DATE,
  LOCALE_RU,
  NAME_REDUCER_PROFILE,
} from '../../shared/consts';
import { Store } from '@ngrx/store';
import { QuantoriumService } from '../../shared/services/quantorium.service';
import { ImageService } from '../../shared/services/image.service';
import { LessonModel } from '../../shared/models/lesson.model';
import { formatDate } from '@angular/common';

@Component({
  selector: 'app-attendance',
  templateUrl: './attendance.component.html',
  styleUrls: ['./attendance.component.scss'],
})
export class AttendanceComponent implements OnInit, OnDestroy {
  range = new FormGroup({
    start: new FormControl<Date | null>(null, [Validators.required]),
    end: new FormControl<Date | null>(null, [Validators.required]),
  });
  lessons: LessonModel[] = [];
  quantums: QuantumModel[] = [];
  groups: GroupModel[] = [];
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  quantumControl = new FormControl<number | null>(null, [Validators.required]);
  groupControl = new FormControl<number | null>(null, [Validators.required]);
  displayedColumns: any[] = [];
  columnsToDisplay: any[] = [];
  dataSource: any[] = [];
  ps: any;
  constructor(
    private store: Store<{ profile: FullUserModel }>,
    private imageService: ImageService,
    private quantoriumService: QuantoriumService
  ) {}
  ngOnDestroy(): void {
    this.ps.unsubscribe();
  }

  ngOnInit() {
    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
      if (this.profile.id != -1) {
        if (this.profile.teacher) {
          this.quantumControl.setValue(this.profile.teacher.quantum_id);
        }
        this.quantoriumService
          .GetGroups(this.getUser()?.quantorium_id)
          .subscribe((groups) => (this.groups = groups));
        this.quantoriumService
          .GetQuantums(this.getUser()?.quantorium_id)
          .subscribe((quantums) => (this.quantums = quantums));
      }
    });
  }
  getUser() {
    if (this.profile.representative) return this.profile.representative;
    if (this.profile.teacher) return this.profile.teacher;
    return null;
  }
  getLessons() {
    let quantum = this.quantumControl.value;
    let group = this.groupControl.value;
    let { start, end } = this.range.value;
    if (start && end && quantum && group) {
      this.quantoriumService
        .GetLessons({
          date_begin: formatDate(start, FORMAT_DATE, LOCALE_RU),
          date_end: formatDate(end, FORMAT_DATE, LOCALE_RU),
          quantum_id: quantum,
          group_id: group,
        })
        .subscribe((lessons) => {
          this.displayedColumns = [];
          this.columnsToDisplay = ['demo-name'];

          this.dataSource = [];
          for (let i = 0; i < lessons.length; i++) {
            const obj = lessons[i];
            let date = formatDate(obj.date, 'dd MMMM', LOCALE_RU);
            this.displayedColumns.push(date);
            this.columnsToDisplay.push(date);

            for (let j = 0; j < obj.presences.length; j++) {
              const presence = obj.presences[j];
              let s = presence.student;
              let id = `${s.user_id}`;
              let m = this.dataSource.find((p) => p.get('id') == id);

              if (!m) {
                let fn = `${s.user.lastname} ${s.user.firstname[0]}. ${s.patronymic[0]}.`;
                m = new Map([
                  ['id', `${s.user_id}`],
                  ['ФИО', fn],
                ]);
                this.dataSource.push(m);
              }
              m.set(date, presence.is_here ? '' : 'н');
            }
          }

          this.dataSource = this.dataSource.map((data) =>
            Object.fromEntries(data)
          );
        });
    }
  }

  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
}
