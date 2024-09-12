import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { SharedModule } from './shared/shared.module';
import { CookieService } from './shared/services/cookie.service';
import { AuthService } from './shared/services/auth.service';
import { ErrorService } from './shared/services/error.service';
import { UserService } from './shared/services/user.service';
import { ImageService } from './shared/services/image.service';
import { QuantoriumService } from './shared/services/quantorium.service';
import { MAT_DATE_LOCALE } from '@angular/material/core';
import { MY_DATE_FORMATS } from './date-format';
import { provideMomentDateAdapter } from '@angular/material-moment-adapter';
import 'moment/locale/ru';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, SharedModule],
  providers: [
    ErrorService,
    AuthService,
    CookieService,
    UserService,
    ImageService,
    QuantoriumService,
    { provide: MAT_DATE_LOCALE, useValue: 'ru' },
    provideMomentDateAdapter(MY_DATE_FORMATS),
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent {
  title = 'quantorium';
}
