import {
  AddedNewsEvent,
  DeletedScheduleItemEvent,
  EditedNewsEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { ImageService } from './../../shared/services/image.service';
import { Component, Inject, OnDestroy, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { onOpenFileDialog, showMessage } from '../../shared/utils';
import { ACCEPT_IMAGES } from '../../shared/consts';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { NewsModel } from '../../shared/models/news.model';
export type DialogAddNewsData = {
  isEdit: boolean;
  news: NewsModel | null;
};
@Component({
  selector: 'app-dialog-add-news',
  templateUrl: './dialog-add-news.component.html',
  styleUrls: ['./dialog-add-news.component.scss'],
})
export class DialogAddNewsComponent implements OnInit, OnDestroy {
  acceptImages = ACCEPT_IMAGES;
  img: string | ArrayBuffer | null = null;
  attach_file: any = null;
  loadingFile = false;
  nameControl = new FormControl('', [Validators.required]);
  descriptionControl = new FormControl('');
  form = new FormGroup({
    name: this.nameControl,
    description: this.descriptionControl,
  });
  firstnameInput = {
    label: 'Заголовок',
    type: 'text',
    placeholder: 'Введите заголовок',
    icon: 'title',
    formControl: this.nameControl,
    messageError: () => {
      let e = this.nameControl?.['errors'];
      if (e?.['required']) return 'Введите заголовок';
      return '';
    },
  };
  descriptionInput = {
    label: 'Описание',
    placeholder: 'Введите описание',
    formControl: this.descriptionControl,
  };
  constructor(
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: DialogAddNewsData,
    public dialogRef: MatDialogRef<DialogAddNewsComponent>,
    private imageService: ImageService,
    private quantoriumService: QuantoriumService
  ) {}
  ngOnDestroy(): void {}
  ngOnInit() {
    if (this.data.isEdit && this.data.news) {
      this.nameControl.setValue(this.data.news.title);
      this.descriptionControl.setValue(this.data.news.description);
      if (this.data.news?.img) {
        this.img = this.compileUrl(this.data.news?.img);
        this.attach_file = this.data.news?.img;
      }
    }
    AddedNewsEvent.subscribe(() => this.dialogRef.close(true));
    EditedNewsEvent.subscribe(() => this.dialogRef.close(true));
  }
  save() {
    const { name, description } = this.form.value;

    if (name) {
      if (this.data.isEdit)
        this.quantoriumService.EditNews({
          title: name,
          description: description,
          img: this.attach_file,
          id: this.data.news?.id,
        });
      else
        this.quantoriumService.AddNews({
          title: name,
          description: description,
          img: this.attach_file,
        });
    }
  }

  fileChange(event: any) {
    let fileList: FileList = event.target.files;
    if (!fileList.length) return;

    let reader = new FileReader();
    reader.onloadend = () => {
      this.img = reader.result;
    };

    let image = fileList[0];
    reader.readAsDataURL(image);
    showMessage(this.snackBar, 'Загрузка изображения...');
    this.loadingFile = true;
    this.imageService.LoadFile(image).subscribe((res) => {
      showMessage(this.snackBar, 'Изображение загружено');
      this.attach_file = res;
      this.loadingFile = false;
    });
  }

  onOpenFileDialog(name: string) {
    onOpenFileDialog(name);
  }

  deleteImg() {
    this.img = null;
    this.imageService.DeleteFile(this.attach_file).subscribe((res) => {
      showMessage(this.snackBar, res.message);
      this.attach_file = null;
    });
  }

  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
}
