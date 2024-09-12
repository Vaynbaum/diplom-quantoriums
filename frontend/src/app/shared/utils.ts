import {
  MatSnackBar,
  MatSnackBarHorizontalPosition,
  MatSnackBarVerticalPosition,
} from '@angular/material/snack-bar';
import { FullUserModel, UserStudentTeacherModel } from './models/user.model';

export function showMessage(
  snackBar: MatSnackBar,
  text?: string,
  action: string = 'OK',
  horizontal: MatSnackBarHorizontalPosition = 'center',
  vertical: MatSnackBarVerticalPosition = 'top',
  duration: number = 5000
) {
  if (text)
    snackBar.open(text, action, {
      horizontalPosition: horizontal,
      verticalPosition: vertical,
      duration: duration,
    });
}

export function showError(error: any, snackBar: MatSnackBar) {
  if (Array.isArray(error.error.detail)) {
    showMessage(snackBar, error.error.detail[0].msg);
  } else if (error.error.detail) {
    showMessage(snackBar, error.error.detail);
  }
}
export function getFullname(p: FullUserModel | any) {
  let patr = '';
  if (p.representative) patr = p.representative?.patronymic;
  else if (p.teacher) patr = p.teacher?.patronymic;
  else if (p.student) patr = p.student?.patronymic;
  let fullname = `${p.lastname} ${p.firstname}`;
  if (patr) fullname += ` ${patr}`;
  return fullname;
}
export function onOpenFileDialog(name: string) {
  document.getElementById(name)?.click();
}
