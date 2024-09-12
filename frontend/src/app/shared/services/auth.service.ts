import { HttpClient } from '@angular/common/http';
import { EventEmitter, Injectable } from '@angular/core';
import { CookieService } from './cookie.service';
import { environment } from '../../../environments/environment';
import { SigninModel } from '../models/signin.model';
import { TokensModel } from '../models/tokens.model';
import { Router } from '@angular/router';
import { catchError } from 'rxjs';
import { ErrorService } from './error.service';
import { LINK_PAGE_PROFILE, LINK_PAGE_SIGNIN } from '../consts';
import { MessageModel } from '../models/message.model';

const AUTH_URL = `${environment.BACKEND_URL}/user`;
const KEY_ACCESS_TOKEN = 'access_token';
const KEY_REFRESH_TOKEN = 'refresh_token';
const EXPIRES_ACCESS_TOKEN = 1;
const EXPIRES_REFRESH_TOKEN = 5;
export type parametersRefreshToken = {
  action: EventEmitter<any>;
  parametr: any;
};
export const refreshTokenEvent = new EventEmitter<parametersRefreshToken>();
export type changePasswordParams = {
  code: string;
  password: string;
};

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  constructor(
    private router: Router,
    private httpClient: HttpClient,
    private errorService: ErrorService,
    private cookieService: CookieService
  ) {
    refreshTokenEvent.subscribe((res) => {
      this.RefreshToken().subscribe(
        (tokens) => {
          this.SaveTokens(tokens);
          res.action.emit(res.parametr);
        },
        (err) => {
          this.DeleteTokens();
          this.router.navigate([LINK_PAGE_SIGNIN], {
            queryParams: { authAgain: true },
          });
        }
      );
    });
  }

  Signin(signinModel: SigninModel) {
    this.httpClient
      .post<TokensModel>(`${AUTH_URL}/signin`, signinModel)
      .pipe(catchError(this.errorService.showError))
      .subscribe((tokens: TokensModel) => {
        this.SaveTokens(tokens);
        this.router.navigate([LINK_PAGE_PROFILE]);
      });
  }

  CreateRecovery(email: string) {
    this.httpClient
      .post<MessageModel>(`${AUTH_URL}/create_recovery`, {
        email: email,
      })
      .pipe(catchError(this.errorService.showError))
      .subscribe((message) => {
        this.errorService.showMessage(new MessageModel('Письмо с ссылкой для сброса отправлено на почту'));
      });
  }
  ChangePassword(data: changePasswordParams) {
    this.httpClient
      .put<MessageModel>(`${AUTH_URL}/change_password_recovery`, data)
      .pipe(catchError(this.errorService.showError))
      .subscribe((message) => {
        this.errorService.showMessage(message);
      });
  }

  IsLoggedIn() {
    return this.cookieService.GetCookie(KEY_REFRESH_TOKEN) != null;
  }

  RefreshToken() {
    return this.httpClient.get<TokensModel>(`${AUTH_URL}/refresh_token`);
  }

  DeleteTokens() {
    this.cookieService.DeleteCookie(KEY_ACCESS_TOKEN);
    this.cookieService.DeleteCookie(KEY_REFRESH_TOKEN);
  }

  SaveTokens(pair: TokensModel) {
    this.cookieService.SetCookie({
      name: KEY_ACCESS_TOKEN,
      value: pair.access_token,
      expireDays: EXPIRES_ACCESS_TOKEN,
      secure: true,
    });
    this.cookieService.SetCookie({
      name: KEY_REFRESH_TOKEN,
      value: pair.refresh_token,
      expireDays: EXPIRES_REFRESH_TOKEN,
      secure: true,
    });
  }

  GetAccessToken() {
    return this.cookieService.GetCookie(KEY_ACCESS_TOKEN);
  }

  GetRefreshToken() {
    return this.cookieService.GetCookie(KEY_REFRESH_TOKEN);
  }
}
