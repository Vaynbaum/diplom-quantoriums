import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import {
  AddedGroupEvent,
  AddedQuantumEvent,
  AddedRoomEvent,
  EditedGroupEvent,
  QuantoriumService,
} from '../../shared/services/quantorium.service';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { GroupModel } from '../../shared/models/group.model';
export type DialogAddQuantumData = {
  is_quantum: boolean;
  is_group: boolean;
  is_room: boolean;
  isEdit: boolean;
  group: GroupModel | undefined;
};
@Component({
  selector: 'app-dialog-add-quantum',
  templateUrl: './dialog-add-quantum.component.html',
  styleUrls: ['./dialog-add-quantum.component.scss'],
})
export class DialogAddQuantumComponent implements OnInit {
  title = '';
  nameControl = new FormControl<string | null>(null, [Validators.required]);
  form = new FormGroup({
    name: this.nameControl,
  });
  firstnameInput = {
    label: this.getLabel(),
    type: 'text',
    placeholder: 'Введите название',
    icon: 'title',
    formControl: this.nameControl,
    messageError: () => {
      let e = this.nameControl?.['errors'];
      if (e?.['required']) return 'Введите название';
      return '';
    },
  };
  getLabel() {
    if (this.data.is_quantum) return 'Название квантума';
    if (this.data.is_group) return 'Группа';
    if (this.data.is_room) return 'Кабинет';
    return '';
  }
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogAddQuantumData,
    private quantoriumService: QuantoriumService,
    public dialogRef: MatDialogRef<DialogAddQuantumComponent>
  ) {}

  ngOnInit() {
    if (this.data.isEdit) {
      if (this.data.group) this.nameControl.setValue(this.data.group.name);
    }
    if (this.data.is_quantum) this.title = 'Квантум';
    else if (this.data.is_group) this.title = 'Группа';
    else if (this.data.is_room) this.title = 'Кабинет';
    AddedQuantumEvent.subscribe(() => this.dialogRef.close(true));
    AddedGroupEvent.subscribe(() => this.dialogRef.close(true));
    AddedRoomEvent.subscribe(() => this.dialogRef.close(true));
    EditedGroupEvent.subscribe(() => this.dialogRef.close(true));
  }

  save() {
    const { name } = this.form.value;
    if (name) {
      if (this.data.isEdit) {
        if (this.data.group)
          this.quantoriumService.EditGroup({
            id: this.data.group.id,
            name: name,
          });
      } else {
        if (this.data.is_quantum) this.quantoriumService.AddQuantum(name);
        if (this.data.is_group) this.quantoriumService.AddGroup(name);
        if (this.data.is_room) this.quantoriumService.AddRoom(name);
      }
    }
  }
}
