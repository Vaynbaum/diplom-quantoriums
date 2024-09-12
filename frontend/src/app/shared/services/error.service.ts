import { EventEmitter, Injectable } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { throwError } from 'rxjs';
import { MatSnackBar } from '@angular/material/snack-bar';
import { showError, showMessage } from '../utils';
import { refreshTokenEvent } from './auth.service';
import { MessageModel } from '../models/message.model';

const showErrorEvent = new EventEmitter<any>();
const tokenErrorEvent = new EventEmitter<any>();

@Injectable({
  providedIn: 'root',
})
export class ErrorService {
  constructor(private snackBar: MatSnackBar) {
    showErrorEvent.subscribe((error) => {
      showError(error, this.snackBar);
    });
  }
  showError(error: HttpErrorResponse) {
    showErrorEvent.emit(error);
    return throwError(error);
  }

  showMessage(message: MessageModel) {
    showMessage(this.snackBar, message.message);
  }

  tokenError(error: HttpErrorResponse) {
    tokenErrorEvent.emit(error);
    return throwError(error);
  }

  handleError(error: any, action: any, parametr?: any, is_show?: boolean) {
    if (error instanceof HttpErrorResponse) {
      const status = error.status;
      if (status === 401)
        refreshTokenEvent.emit({ action: action, parametr: parametr });
      else if (is_show) showError(error, this.snackBar);
    }
  }
}
