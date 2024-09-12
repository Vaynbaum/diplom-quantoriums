import {
  AddedRepresentativeEvent,
  UserService,
} from './../../shared/services/user.service';
import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

export type DialogAddRepresentativeData = {
  quantoriumId: number;
};

export type Input = {
  label: string;
  type: string;
  placeholder: string;
  icon: string;
  formControl: any;
  messageError: () => {};
};

@Component({
  selector: 'app-dialog-add-representative',
  templateUrl: './dialog-add-representative.component.html',
  styleUrls: ['./dialog-add-representative.component.scss'],
})
export class DialogAddRepresentativeComponent implements OnInit {
  emailControl = new FormControl(null, [Validators.required, Validators.email]);
  firstnameControl = new FormControl(null, [Validators.required]);
  lastnameControl = new FormControl(null, [Validators.required]);
  patronymicControl = new FormControl(null, [Validators.required]);
  phoneControl = new FormControl(null, [Validators.required]);
  form = new FormGroup({
    email: this.emailControl,
    firstname: this.firstnameControl,
    lastname: this.lastnameControl,
    patronymic: this.patronymicControl,
    phone: this.phoneControl,
  });
  emailInput: Input = {
    label: 'Электронная почта',
    type: 'email',
    placeholder: 'mail@example.ru',
    icon: 'email',
    formControl: this.emailControl,
    messageError: () => {
      let e = this.emailControl?.['errors'];
      if (e?.['required']) return 'Введите почту';
      if (e?.['email']) return 'Введите корректную почту';
      return '';
    },
  };
  firstnameInput: Input = {
    label: 'Имя',
    type: 'text',
    placeholder: 'Иван',
    icon: 'badge',
    formControl: this.firstnameControl,
    messageError: () => {
      let e = this.firstnameControl?.['errors'];
      if (e?.['required']) return 'Введите имя';
      return '';
    },
  };
  lastnameInput: Input = {
    label: 'Фамилия',
    type: 'text',
    placeholder: 'Иванов',
    icon: 'badge',
    formControl: this.lastnameControl,
    messageError: () => {
      let e = this.lastnameControl?.['errors'];
      if (e?.['required']) return 'Введите фамилию';
      return '';
    },
  };
  patronymicInput: Input = {
    label: 'Отчество',
    type: 'text',
    placeholder: 'Иванович',
    icon: 'badge',
    formControl: this.patronymicControl,
    messageError: () => {
      let e = this.patronymicControl?.['errors'];
      if (e?.['required']) return 'Введите отчество';
      return '';
    },
  };
  phoneInput = {
    label: 'Телефон',
    type: 'tel',
    placeholder: '+7 (999) 999 99-99',
    icon: 'call',
    formControl: this.phoneControl,
    messageError: () => {
      let e = this.phoneControl?.['errors'];
      if (e?.['required']) return 'Введите телефон';
      return '';
    },
  };
  fields: Input[] = [
    this.lastnameInput,
    this.firstnameInput,
    this.patronymicInput,
    this.emailInput,
    this.phoneInput,
  ];

  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogAddRepresentativeData,
    private userService: UserService,
    public dialogRef: MatDialogRef<DialogAddRepresentativeComponent>
  ) {}

  ngOnInit() {
    AddedRepresentativeEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }

  save() {
    const { email, phone, firstname, lastname, patronymic } = this.form.value;

    if (email && phone && firstname && lastname && patronymic) {
      this.userService.AddRepresentative({
        email: email,
        phone: phone,
        firstname: firstname,
        lastname: lastname,
        patronymic: patronymic,
        quantorium_id: this.data.quantoriumId,
      });
    }
  }
}
