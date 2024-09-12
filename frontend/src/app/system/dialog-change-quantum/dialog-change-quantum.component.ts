import {
  ChangedQuantumEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ImageService } from '../../shared/services/image.service';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { UserStudentTeacherModel } from '../../shared/models/user.model';
export type DialogChangeQuantumData = {
  quantums: QuantumModel[];
  user: UserStudentTeacherModel;
};
@Component({
  selector: 'app-dialog-change-quantum',
  templateUrl: './dialog-change-quantum.component.html',
  styleUrls: ['./dialog-change-quantum.component.scss'],
})
export class DialogChangeQuantumComponent implements OnInit {
  quantumControl = new FormControl(this.data.user.teacher.quantum_id, [
    Validators.required,
  ]);
  form = new FormGroup({ quantum: this.quantumControl });
  quantumInput = {
    label: 'Квантум учителя',
    formControl: this.quantumControl,
    placeholder: 'Выберите квантум',
    messageError: () => {
      let e = this.quantumControl?.['errors'];
      if (e?.['required']) return 'Выберите квантум';
      return '';
    },
  };
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogChangeQuantumData,
    private quantoriumService: QuantoriumService,
    public dialogRef: MatDialogRef<DialogChangeQuantumComponent>,
    private imageService: ImageService
  ) {}

  ngOnInit() {
    ChangedQuantumEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }
  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
  save() {
    const { quantum } = this.form.value;
    if (quantum) {
      this.quantoriumService.ChangeQuantum({
        teacher_id: this.data.user.id,
        quantum_id: quantum as number,
      });
    }
  }
}
