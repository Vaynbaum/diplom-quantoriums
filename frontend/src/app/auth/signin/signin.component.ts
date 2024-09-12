import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { SigninModel } from '../../shared/models/signin.model';
import { AuthService } from '../../shared/services/auth.service';
import { ActivatedRoute, Params } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { showMessage } from '../../shared/utils';
import { EMAIL_SUPPORT } from '../../shared/consts';

@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html',
  styleUrls: ['./signin.component.scss'],
})
export class SigninComponent implements OnInit {
  title = 'Личный кабинет';
  titleSupport = 'Техническая поддержка ЛК';
  emailSupport = EMAIL_SUPPORT;
  resetBtn = { title: 'Сбросить пароль', link: '/auth/recovery' };
  authBtn = 'Войти';
  constructor(
    private authService: AuthService,
    private route: ActivatedRoute,
    private _snackBar: MatSnackBar
  ) {}

  emailControl = new FormControl(null, [Validators.required, Validators.email]);
  passwordControl = new FormControl(null, [
    Validators.required,
    Validators.minLength(8),
  ]);
  form = new FormGroup({
    email: this.emailControl,
    password: this.passwordControl,
  });
  emailInput = {
    label: 'Электронная почта',
    type: 'email',
    placeholder: 'mail@example.ru',
    icon: 'email',
    formControl: this.emailControl,
    messageError: () => {
      let e = this.emailControl?.['errors'];
      if (e?.['required']) return 'Почта не может быть пустой';
      if (e?.['email']) return 'Введите корректную почту';
      return '';
    },
  };
  passwordInput = {
    label: 'Пароль',
    placeholder: 'Введите пароль',
    formControl: this.passwordControl,
    hide: true,
    type: () => {
      return this.passwordInput.hide ? 'password' : 'text';
    },
    icon: () => {
      return this.passwordInput.hide ? 'visibility_off' : 'visibility';
    },
    toggle: () => {
      this.passwordInput.hide = !this.passwordInput.hide;
    },
    messageError: () => {
      let e = this.passwordControl?.['errors'];
      if (e?.['required']) return 'Пароль не может быть пустым';
      let e_m = e?.['minlength'];
      if (e_m && e_m['requiredLength'])
        return `Пароль меньше ${e_m['requiredLength']} символов`;
      if (e?.['passwordNotMatch']) return 'Пароли не совпадают';
      return '';
    },
  };

  signin() {
    const { email, password } = this.form.value;
    if (email && password) {
      showMessage(this._snackBar, 'Вход в систему...');
      this.authService.Signin(new SigninModel(email, password));
    }
  }
  ngOnInit() {
    this.route.queryParams.subscribe((params: Params) => {
      if (params['authAgain']) {
        showMessage(this._snackBar, 'Необходимо заново авторизоваться');
      } else if (params['logoutSuccess']) {
        showMessage(this._snackBar, 'Вы вышли из аккаунта');
      } else if (params['message']) {
        showMessage(this._snackBar, params['message']);
      } else if (params['accessDenied'])
        showMessage(this._snackBar, 'Авторизуйтесь чтобы попасть в систему');
      else if (params['deleteUser']) {
        showMessage(this._snackBar, 'Ваш аккаунт успешно удалён');
      }
    });
  }
}
