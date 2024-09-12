import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ImageService } from '../../shared/services/image.service';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { UserStudentTeacherModel } from '../../shared/models/user.model';
import {
  AddedQuantumLinkEvent,
  QuantoriumService,
} from '../../shared/services/quantorium.service';
export type DialogAddQuantumLinkData = {
  quantums: QuantumModel[];
  user: UserStudentTeacherModel;
};
@Component({
  selector: 'app-dialog-add-quantum-link',
  templateUrl: './dialog-add-quantum-link.component.html',
  styleUrls: ['./dialog-add-quantum-link.component.scss'],
})
export class DialogAddQuantumLinkComponent implements OnInit {
  quantumControl = new FormControl(null, [Validators.required]);
  is_free = true;
  form = new FormGroup({
    quantum: this.quantumControl,
    isActive: new FormControl(this.is_free, [Validators.required]),
  });
  quantumInput = {
    label: 'Квантум',
    formControl: this.quantumControl,
    placeholder: 'Выберите квантум',
    messageError: () => {
      let e = this.quantumControl?.['errors'];
      if (e?.['required']) return 'Выберите квантум';
      return '';
    },
  };
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogAddQuantumLinkData,
    public dialogRef: MatDialogRef<DialogAddQuantumLinkComponent>,
    private imageService: ImageService,
    private quantoriumService: QuantoriumService
  ) {}

  ngOnInit() {
    AddedQuantumLinkEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }
  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
  onChange() {
    // @ts-ignore
    this.is_free = this.form.get('isActive')?.value;
  }
  save() {
    const { quantum } = this.form.value;
    if (quantum) {
      this.quantoriumService.AddQuantumLink({
        student_id: this.data.user.id,
        quantum_id: quantum as number,
        is_free: this.is_free,
      });
    }
  }
}
