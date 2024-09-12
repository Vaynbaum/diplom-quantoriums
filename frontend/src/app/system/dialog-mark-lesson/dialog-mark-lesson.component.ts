import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { FullScheduleModel } from '../../shared/models/schedule.model';
import {
  AddedLessonEvent,
  QuantoriumService,
} from '../../shared/services/quantorium.service';
import { StudentUserModel } from '../../shared/models/user.model';
import { ImageService } from '../../shared/services/image.service';
import { formatDate } from '@angular/common';
import { FORMAT_DATE, LOCALE_RU } from '../../shared/consts';
export type DialogMarkLesson = {
  schedule: FullScheduleModel;
  date: Date;
};
@Component({
  selector: 'app-dialog-mark-lesson',
  templateUrl: './dialog-mark-lesson.component.html',
  styleUrls: ['./dialog-mark-lesson.component.scss'],
})
export class DialogMarkLessonComponent implements OnInit {
  students: StudentUserModel[] = [];
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogMarkLesson,
    private quantoriumService: QuantoriumService,
    private imageService: ImageService,
    public dialogRef: MatDialogRef<DialogMarkLessonComponent>
  ) {}

  ngOnInit() {
    AddedLessonEvent.subscribe(() => this.dialogRef.close(true));
    this.quantoriumService
      .GetGroup(this.data.schedule.schedule_item.group_id)
      .subscribe(
        (group) =>
          (this.students = group.students.map((student) => {
            student.is_here = false;
            return student;
          }))
      );
  }
  save() {
    let b = formatDate(this.data.date, FORMAT_DATE, LOCALE_RU);
    let presences = this.students.map((student) => {
      return { student_id: student.user_id, is_here: student.is_here };
    });
    let data = {
      group_id: this.data.schedule.schedule_item.group_id,
      time_begin: this.data.schedule.schedule_item.time_begin + '.000Z',
      time_end: this.data.schedule.schedule_item.time_end + '.000Z',
      date: b,
      presences: presences,
    };
    this.quantoriumService.AddLesson(data);
  }
  getFullname(student: StudentUserModel) {
    return `${student.user.lastname} ${student.user.firstname} ${student.patronymic}`;
  }
  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
}
