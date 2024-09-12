import { Injectable } from '@angular/core';
import {
  HttpEvent,
  HttpInterceptor,
  HttpHandler,
  HttpRequest,
} from '@angular/common/http';

import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { HEADER_NAME_AUTHORIZATION } from './const';
import { AuthService } from '../services/auth.service';
import { ErrorService } from '../services/error.service';

@Injectable()
export class TokensInterceptor implements HttpInterceptor {
  constructor(
    private authService: AuthService,
    private errorService: ErrorService
  ) {}

  setHeader(req: HttpRequest<any>, token: string) {
    if (token) {
      req = req.clone({
        headers: req.headers.set(HEADER_NAME_AUTHORIZATION, `Bearer ${token}`),
      });
    }
    return req;
  }

  intercept(
    req: HttpRequest<any>,
    next: HttpHandler
  ): Observable<HttpEvent<any>> {
    let token = null;
    let is_ref = req.url.includes(`/user/refresh_token`);

    if (is_ref) token = this.authService.GetRefreshToken();
    else token = this.authService.GetAccessToken();
    if (token) req = this.setHeader(req, token);
    return next.handle(req);
  }
}
