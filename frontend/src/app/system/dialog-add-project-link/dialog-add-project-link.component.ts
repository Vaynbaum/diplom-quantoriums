import {
  AddedProjectLinkEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { FullGroupModel, GroupModel } from '../../shared/models/group.model';
import { StudentUserModel } from '../../shared/models/user.model';
import { ImageService } from '../../shared/services/image.service';
export type DialogAddProjectLinkData = {
  project_id: number;
  group_id: number;
};
@Component({
  selector: 'app-dialog-add-project-link',
  templateUrl: './dialog-add-project-link.component.html',
  styleUrls: ['./dialog-add-project-link.component.scss'],
})
export class DialogAddProjectLinkComponent implements OnInit {
  roleControl = new FormControl('', [Validators.required]);
  studentControl = new FormControl(null, [Validators.required]);
  students: StudentUserModel[] = [];
  form = new FormGroup({
    role: this.roleControl,
    student: this.studentControl,
  });
  roleInput = {
    type: 'text',
    label: 'Роль в проекте',
    icon: 'badge',
    formControl: this.roleControl,
    placeholder: 'Введите роль',
    messageError: () => {
      let e = this.roleControl?.['errors'];
      if (e?.['required']) return 'Введите роль';
      return '';
    },
  };
  studentInput = {
    label: 'Учащийся',
    formControl: this.studentControl,
    placeholder: 'Выберите учащегося',
    messageError: () => {
      let e = this.studentControl?.['errors'];
      if (e?.['required']) return 'Выберите учащегося';
      return '';
    },
  };
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogAddProjectLinkData,
    private quantoriumService: QuantoriumService,
    private imageService: ImageService,
    public dialogRef: MatDialogRef<DialogAddProjectLinkComponent>
  ) {}

  ngOnInit() {
    this.quantoriumService.GetGroup(this.data.group_id).subscribe((group) => {
      this.quantoriumService
        .GetProject(this.data.project_id)
        .subscribe((project) => {
          group.students.forEach((student) => {
            let p = project.project_links.find(
              (l) => l.student_id == student.user_id
            );
            if (!p) this.students.push(student);
          });
        });
    });

    AddedProjectLinkEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }
  getFullname(teacher: StudentUserModel) {
    return `${teacher.user.lastname} ${teacher.user.firstname} ${teacher.patronymic}`;
  }
  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
  save() {
    const { role, student } = this.form.value;
    if (role && student) {
      this.quantoriumService.AddProjectLink({
        role: role as string,
        student_id: student,
        project_id: this.data.project_id,
      });
    }
  }
}
