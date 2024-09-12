import {
  ChangedGroupEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { GroupModel } from '../../shared/models/group.model';
import { UserStudentTeacherModel } from '../../shared/models/user.model';
import { ImageService } from '../../shared/services/image.service';
export type DialogChangeGroupData = {
  groups: GroupModel[];
  user: UserStudentTeacherModel;
};
@Component({
  selector: 'app-dialog-change-group',
  templateUrl: './dialog-change-group.component.html',
  styleUrls: ['./dialog-change-group.component.scss'],
})
export class DialogChangeGroupComponent implements OnInit {
  groupControl = new FormControl(this.data.user.student.group_id, [
    Validators.required,
  ]);
  form = new FormGroup({ group: this.groupControl });
  groupInput = {
    label: 'Группа учащегося',
    formControl: this.groupControl,
    placeholder: 'Выберите группу',
    messageError: () => {
      let e = this.groupControl?.['errors'];
      if (e?.['required']) return 'Выберите группу';
      return '';
    },
  };
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogChangeGroupData,
    private quantoriumService: QuantoriumService,
    public dialogRef: MatDialogRef<DialogChangeGroupComponent>,
    private imageService: ImageService
  ) {}

  ngOnInit() {
    console.log(this.data)
    ChangedGroupEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }
  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
  save() {
    const { group } = this.form.value;
    if (group) {
      this.quantoriumService.ChangeGroup({
        student_id: this.data.user.id,
        group_id: group as number,
      });
    }
  }
}
