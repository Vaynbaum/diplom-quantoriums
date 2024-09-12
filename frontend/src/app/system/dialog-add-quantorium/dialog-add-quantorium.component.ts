import {
  AddedQuantoriumEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-dialog-add-quantorium',
  templateUrl: './dialog-add-quantorium.component.html',
  styleUrls: ['./dialog-add-quantorium.component.scss'],
})
export class DialogAddQuantoriumComponent implements OnInit {
  nameControl = new FormControl(null, [Validators.required]);
  form = new FormGroup({ name: this.nameControl });
  firstnameInput = {
    label: 'Название',
    type: 'text',
    placeholder: 'Кванториум',
    icon: 'title',
    formControl: this.nameControl,
    messageError: () => {
      let e = this.nameControl?.['errors'];
      if (e?.['required']) return 'Введите название';
      return '';
    },
  };
  constructor(
    private quantoriumService: QuantoriumService,
    public dialogRef: MatDialogRef<DialogAddQuantoriumComponent>
  ) {}

  ngOnInit() {
    AddedQuantoriumEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }
  save() {
    const { name } = this.form.value;
    if (name) this.quantoriumService.AddQuantorium(name);
  }
}
