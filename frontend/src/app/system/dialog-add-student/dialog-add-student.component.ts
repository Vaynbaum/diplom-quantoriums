import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ImageService } from '../../shared/services/image.service';
import {
  AddedStudentEvent,
  UserService,
} from '../../shared/services/user.service';
import { GroupModel } from '../../shared/models/group.model';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { formatDate } from '@angular/common';
import { FORMAT_DATE, LOCALE_RU, STUDENT_ROLE } from '../../shared/consts';
export type DialogAddStudentData = {
  groups: GroupModel[];
};
@Component({
  selector: 'app-dialog-add-student',
  templateUrl: './dialog-add-student.component.html',
  styleUrls: ['./dialog-add-student.component.scss'],
})
export class DialogAddStudentComponent implements OnInit {
  emailControl = new FormControl(null, [Validators.required, Validators.email]);
  firstnameControl = new FormControl(null, [Validators.required]);
  lastnameControl = new FormControl(null, [Validators.required]);
  patronymicControl = new FormControl(null, [Validators.required]);
  phoneControl = new FormControl(null, [Validators.required]);
  groupControl = new FormControl(null, [Validators.required]);
  birthdayControl = new FormControl(null, [Validators.required]);
  form = new FormGroup({
    email: this.emailControl,
    firstname: this.firstnameControl,
    lastname: this.lastnameControl,
    patronymic: this.patronymicControl,
    phone: this.phoneControl,
    group: this.groupControl,
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
    @Inject(MAT_DIALOG_DATA) public data: DialogAddStudentData,
    private userService: UserService,
    public dialogRef: MatDialogRef<DialogAddStudentComponent>,
    private imageService: ImageService
  ) {}

  ngOnInit() {
    AddedStudentEvent.subscribe((res) => {
      this.dialogRef.close(true);
    });
  }
  save() {
    const { firstname, lastname, patronymic, email, phone, group, birthday } =
      this.form.value;
    if (
      firstname &&
      lastname &&
      patronymic &&
      email &&
      phone &&
      group &&
      birthday
    ) {
      let b = '';
      if (birthday) b = formatDate(birthday, FORMAT_DATE, LOCALE_RU);
      this.userService.AddStudent({
        email: email as string,
        phone: phone as string,
        firstname: firstname as string,
        lastname: lastname as string,
        patronymic: patronymic as string,
        group_id: group as number,
        birthdate: b,
        role_id: STUDENT_ROLE,
      });
    }
  }
  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
}
