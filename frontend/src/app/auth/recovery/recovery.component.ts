import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { EMAIL_SUPPORT, LINK_PAGE_SIGNIN } from '../../shared/consts';
import { AuthService } from '../../shared/services/auth.service';

@Component({
  selector: 'app-recovery',
  templateUrl: './recovery.component.html',
  styleUrls: ['./recovery.component.scss'],
})
export class RecoveryComponent implements OnInit {
  title = 'Восстановление пароля';
  titleSupport = 'Техническая поддержка ЛК';
  emailSupport = EMAIL_SUPPORT;
  authBtn = 'Востановить';
  resetBtn = { title: 'Авторизоваться', link: LINK_PAGE_SIGNIN };

  emailControl = new FormControl(null, [Validators.required, Validators.email]);

  form = new FormGroup({ email: this.emailControl });
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
  constructor(private authService: AuthService) {}

  ngOnInit() {}
  recovery() {
    const { email } = this.form.value;
    if (email) this.authService.CreateRecovery(email);
  }
}
