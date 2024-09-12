import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { EMAIL_SUPPORT, LINK_PAGE_SIGNIN } from '../../shared/consts';
import { ActivatedRoute } from '@angular/router';
import { AuthService } from '../../shared/services/auth.service';

@Component({
  selector: 'app-reset',
  templateUrl: './reset.component.html',
  styleUrls: ['./reset.component.scss'],
})
export class ResetComponent implements OnInit {
  code: string = '';
  title = 'Смена пароля';
  titleSupport = 'Техническая поддержка ЛК';
  emailSupport = EMAIL_SUPPORT;
  resetBtn = { title: 'Авторизоваться', link: LINK_PAGE_SIGNIN };
  authBtn = 'Сменить';
  passwordControl = new FormControl(null, [
    Validators.required,
    Validators.minLength(8),
  ]);
  form = new FormGroup({ password: this.passwordControl });

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
  constructor(
    private authService: AuthService,
    private activateRoute: ActivatedRoute
  ) {}

  ngOnInit() {
    this.activateRoute.queryParams.subscribe((params) => {
      this.code = params['code'];
    });
  }
  reset() {
    const { password } = this.form.value;
    if (password) {
      this.authService.ChangePassword({ code: this.code, password: password });
    }
  }
}
