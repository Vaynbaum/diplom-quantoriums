import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {
  AddedTeacherEvent,
  UserService,
} from '../../shared/services/user.service';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { formatDate } from '@angular/common';
import { FORMAT_DATE, LOCALE_RU, TEACHER_ROLE } from '../../shared/consts';
import { ImageService } from '../../shared/services/image.service';
export type DialogAddTeacherData = {
  quantums: QuantumModel[];
};
@Component({
  selector: 'app-dialog-add-teacher',
  templateUrl: './dialog-add-teacher.component.html',
  styleUrls: ['./dialog-add-teacher.component.scss'],
})
export class DialogAddTeacherComponent implements OnInit {
  emailControl = new FormControl(null, [Validators.required, Validators.email]);
  firstnameControl = new FormControl(null, [Validators.required]);
  lastnameControl = new FormControl(null, [Validators.required]);
  patronymicControl = new FormControl(null, [Validators.required]);
  phoneControl = new FormControl(null, [Validators.required]);
  quantumControl = new FormControl(null, [Validators.required]);
  birthdayControl = new FormControl(null, [Validators.required]);
  form = new FormGroup({
    email: this.emailControl,
    firstname: this.firstnameControl,
    lastname: this.lastnameControl,
    patronymic: this.patronymicControl,
    phone: this.phoneControl,
    quantum: this.quantumControl,
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
    @Inject(MAT_DIALOG_DATA) public data: DialogAddTeacherData,
    private userService: UserService,
    public dialogRef: MatDialogRef<DialogAddTeacherComponent>,
    private imageService: ImageService
  ) {}

  ngOnInit() {
    AddedTeacherEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }
  save() {
    const { firstname, lastname, patronymic, email, phone, quantum, birthday } =
      this.form.value;
    if (
      firstname &&
      lastname &&
      patronymic &&
      email &&
      phone &&
      quantum &&
      birthday
    ) {
      let b = '';
      if (birthday) b = formatDate(birthday, FORMAT_DATE, LOCALE_RU);
      this.userService.AddTeacher({
        email: email as string,
        phone: phone as string,
        firstname: firstname as string,
        lastname: lastname as string,
        patronymic: patronymic as string,
        quantum_id: quantum as number,
        birthdate: b,
        role_id: TEACHER_ROLE,
      });
    }
  }
  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
}
