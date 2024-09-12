import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {
  AddedReasonEvent,
  QuantoriumService,
} from '../../shared/services/quantorium.service';
import { FormControl, FormGroup, Validators } from '@angular/forms';
export type DialogAddReasonData = {
  quantorium_id: number | undefined | null;
};
@Component({
  selector: 'app-dialog-add-reason',
  templateUrl: './dialog-add-reason.component.html',
  styleUrls: ['./dialog-add-reason.component.scss'],
})
export class DialogAddReasonComponent implements OnInit {
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogAddReasonData,
    private quantoriumService: QuantoriumService,
    public dialogRef: MatDialogRef<DialogAddReasonComponent>
  ) {}
  nameControl = new FormControl('', [Validators.required]);
  titleControl = new FormControl('', [Validators.required]);
  descriptionControl = new FormControl('');
  startControl = new FormControl<Date | null>(null, [Validators.required]);
  endControl = new FormControl<Date | null>(null);
  timeStartControl = new FormControl('');
  timeEndControl = new FormControl('');
  range = new FormGroup({ start: this.startControl, end: this.endControl });
  form = new FormGroup({
    name: this.nameControl,
    title: this.titleControl,
    description: this.descriptionControl,
    time_begin: this.timeStartControl,
    time_end: this.timeEndControl,
  });
  titleInput = {
    label: 'Заголовок новости',
    type: 'text',
    placeholder: 'Введите заголовок',
    icon: 'title',
    formControl: this.titleControl,
    messageError: () => {
      let e = this.titleControl?.['errors'];
      if (e?.['required']) return 'Введите заголовок';
      return '';
    },
  };
  descriptionInput = {
    label: 'Описание новости',
    placeholder: 'Введите описание',
    formControl: this.descriptionControl,
  };
  nameInput = {
    label: 'Название объявления',
    type: 'text',
    formControl: this.nameControl,
    placeholder: 'Введите название',
    messageError: () => {
      let e = this.nameControl?.['errors'];
      if (e?.['required']) return 'Введите название';
      return '';
    },
  };
  dateInput = {
    label: 'Даты отмена занятий',
    mask: 'дд.мм.гггг* - дд.мм.гггг',
    placeholderStart: 'Дата начала*',
    placeholderEnd: 'Дата окончания',
    formControl: this.startControl,
    messageError: () => {
      let e = this.endControl?.['errors'];
      if (e?.['matDatepickerParse'] || e?.['matEndDateInvalid'])
        return 'Некорректная дата окончания';
      e = this.startControl?.['errors'];
      if (e?.['matDatepickerParse'] || e?.['matEndDateInvalid'])
        return 'Некорректная дата начала';
      if (e?.['required']) return 'Выберите дату начала';
      return '';
    },
  };
  timeBeginInput = {
    label: 'Время начала отмены занятий',
    formControl: this.timeStartControl,
    placeholder: 'Введите время начала отмены занятий',
    messageError: () => {
      let e = this.timeStartControl?.['errors'];
      if (e?.['required']) return 'Введите время начала отмены занятий';
      return '';
    },
  };
  timeEndInput = {
    label: 'Время окончания отмены занятий',
    formControl: this.timeEndControl,
    placeholder: 'Введите время окончания отмены занятий',
    messageError: () => {
      let e = this.timeEndControl?.['errors'];
      if (e?.['required']) return 'Введите время окончания отмены занятий';
      return '';
    },
  };
  times = [this.timeBeginInput, this.timeEndInput];
  inps = [this.nameInput, this.titleInput];
  ngOnInit() {
    AddedReasonEvent.subscribe(() => {
      this.dialogRef.close(true);
    });
  }
  save() {
    let { name, title, description, time_begin, time_end } = this.form.value;
    let { start, end } = this.range.value;
    if (name && title) {
      if (time_begin) {
        let t = time_begin.split(':');
        let d = start instanceof Date ? start : (start as any)._d;
        d.setHours(Number(t[0]));
        d.setMinutes(Number(t[1]));
        start = d;
      }
      if (end) {
        if (time_end) {
          let t = time_end.split(':');
          let d = end instanceof Date ? end : (end as any)._d;
          d.setHours(Number(t[0]));
          d.setMinutes(Number(t[1]));
          end = d;
        } else {
          let d = end instanceof Date ? end : (end as any)._d;
          d.setHours(23);
          d.setMinutes(59);
          end = d;
        }
      } else if (start) {
        let d = start instanceof Date ? start : (start as any)._d;
        end = new Date(d.getTime());
        end.setHours(23);
        end.setMinutes(59);
      }
      let data: any = {
        name: name,
        title: title,
        description: description,
        date_begin: start?.toISOString(),
        date_end: end?.toISOString(),
      };
      if (this.data.quantorium_id) data.quantorium_id = this.data.quantorium_id;
      this.quantoriumService.AddReason(data);
    }
  }
}
