import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {
  EditedUserEvent,
  UserService,
} from '../../shared/services/user.service';
import { FullUserModel } from '../../shared/models/user.model';
import {
  FORMAT_DATE,
  LOCALE_RU,
  REPRESENTATIVE_ROLE,
} from '../../shared/consts';
import { formatDate } from '@angular/common';
export type DialogEditUserData = {
  profile: FullUserModel;
  isMy: boolean;
};
@Component({
  selector: 'app-dialog-edit-user',
  templateUrl: './dialog-edit-user.component.html',
  styleUrls: ['./dialog-edit-user.component.scss'],
})
export class DialogEditUserComponent implements OnInit {
  emailControl = new FormControl(this.data.profile.email, [
    Validators.required,
    Validators.email,
  ]);
  firstnameControl = new FormControl(this.data.profile.firstname, [
    Validators.required,
  ]);
  lastnameControl = new FormControl(this.data.profile.lastname, [
    Validators.required,
  ]);
  patronymicControl = new FormControl(this.getProfile()?.patronymic, [
    Validators.required,
  ]);
  phoneControl = new FormControl(this.getProfile()?.phone, [
    Validators.required,
  ]);
  birthdayControl = new FormControl(this.getUser()?.birthdate);
  form = new FormGroup({
    email: this.emailControl,
    firstname: this.firstnameControl,
    lastname: this.lastnameControl,
    patronymic: this.patronymicControl,
    phone: this.phoneControl,
    birthday: this.birthdayControl,
  });
  emailInput = {
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
  firstnameInput = {
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
  lastnameInput = {
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
  patronymicInput = {
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

  birthdayInput = {
    label: 'Дата рождения',
    formControl: this.birthdayControl,
    placeholder: 'Выберите дату',
    messageError: () => {
      let e = this.birthdayControl?.['errors'];
      if (e?.['required']) return 'Выберите дату';
      return '';
    },
  };
  fields = [
    this.lastnameInput,
    this.firstnameInput,
    this.patronymicInput,
    this.emailInput,
    this.phoneInput,
  ];
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogEditUserData,
    private userService: UserService,
    public dialogRef: MatDialogRef<DialogEditUserComponent>
  ) {}

  isUser() {
    return this.data.profile.role_id != REPRESENTATIVE_ROLE;
  }
  getProfile() {
    if (this.data.profile.student) return this.data.profile.student;
    if (this.data.profile.teacher) return this.data.profile.teacher;
    if (this.data.profile.representative)
      return this.data.profile.representative;
    return null;
  }
  getUser() {
    if (this.data.profile.student) return this.data.profile.student;
    if (this.data.profile.teacher) return this.data.profile.teacher;
    return null;
  }
  ngOnInit() {
    if (this.isUser()) this.birthdayControl.addValidators(Validators.required);
    EditedUserEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }

  save() {
    const { firstname, lastname, patronymic, email, phone, birthday } =
      this.form.value;
    if (firstname && lastname && patronymic && email && phone) {
      let id = this.data.isMy ? null : this.data.profile.id;
      let b = null;
      if (birthday) b = formatDate(birthday, FORMAT_DATE, LOCALE_RU);
      this.userService.EditUser({
        id: id,
        email: email as string,
        phone: phone as string,
        firstname: firstname as string,
        lastname: lastname as string,
        patronymic: patronymic as string,
        birthdate: b,
      });
    }
  }
}
