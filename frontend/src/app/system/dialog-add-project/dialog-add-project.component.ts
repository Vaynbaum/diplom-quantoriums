import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { onOpenFileDialog, showMessage } from '../../shared/utils';
import { MatSnackBar } from '@angular/material/snack-bar';
import { FILE_ICONS } from '../../shared/consts';
import { QuantumLinksModel } from '../../shared/models/user.model';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { ImageService } from '../../shared/services/image.service';
import {
  AddedProjectEvent,
  EditedProjectEvent,
  QuantoriumService,
} from '../../shared/services/quantorium.service';
import { ProjectModel } from '../../shared/models/project.model';
export type DialogAddProjectData = {
  quantums: QuantumLinksModel[] | undefined;
  isEdit: boolean;
  project: ProjectModel;
};
@Component({
  selector: 'app-dialog-add-project',
  templateUrl: './dialog-add-project.component.html',
  styleUrls: ['./dialog-add-project.component.scss'],
})
export class DialogAddProjectComponent implements OnInit {
  quantums: QuantumModel[] | undefined = [];
  nameControl = new FormControl('', [Validators.required]);
  descriptionControl = new FormControl('', [Validators.required]);
  quantumControl = new FormControl(null);
  attach_files: any[] = [];
  deleteFiles: any[] = [];
  loadingFile = false;
  form = new FormGroup({
    name: this.nameControl,
    description: this.descriptionControl,
    quantum: this.quantumControl,
  });
  firstnameInput = {
    label: 'Название',
    type: 'text',
    placeholder: 'Введите название',
    icon: 'title',
    formControl: this.nameControl,
    messageError: () => {
      let e = this.nameControl?.['errors'];
      if (e?.['required']) return 'Введите название';
      return '';
    },
  };
  descriptionInput = {
    label: 'Описание',
    placeholder: 'Введите описание',
    formControl: this.descriptionControl,
    messageError: () => {
      let e = this.descriptionControl?.['errors'];
      if (e?.['required']) return 'Введите описание';
      return '';
    },
  };
  quantumInput = {
    label: 'Квантум проекта',
    formControl: this.quantumControl,
    placeholder: 'Выберите квантум',
    messageError: () => {
      let e = this.quantumControl?.['errors'];
      if (e?.['required']) return 'Выберите квантум';
      return '';
    },
  };
  constructor(
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: DialogAddProjectData,
    public dialogRef: MatDialogRef<DialogAddProjectComponent>,
    private imageService: ImageService,
    private quantoriumService: QuantoriumService
  ) {}

  ngOnInit() {
    if (this.data.isEdit) {
      this.nameControl.setValue(this.data.project.name);
      this.descriptionControl.setValue(this.data.project.description);
      this.attach_files = structuredClone(this.data.project.materials.files);
    } else {
      this.quantumControl.addValidators(Validators.required);
    }

    this.quantums = this.data.quantums?.map((quantum) => quantum.quantum);
    AddedProjectEvent.subscribe(() => {
      this.deleteFiles.forEach((file) =>
        this.imageService.DeleteFile(file).subscribe()
      );
      this.dialogRef.close(true);
    });
    EditedProjectEvent.subscribe(() => {
      this.deleteFiles.forEach((file) =>
        this.imageService.DeleteFile(file).subscribe()
      );
      this.dialogRef.close(true);
    });
  }

  save() {
    const { name, description, quantum } = this.form.value;
    if (name && description) {
      if (this.data.isEdit) {
        this.quantoriumService.EditProject({
          id: this.data.project.id,
          name: name,
          description: description,
          materials: { files: this.attach_files },
        });
      } else if (quantum)
        this.quantoriumService.AddProject({
          name: name,
          description: description,
          materials: { files: this.attach_files },
          quantum_id: quantum,
        });
    }
  }

  onOpenFileDialog(name: string) {
    onOpenFileDialog(name);
  }

  fileChange(event: any) {
    let fileList: FileList = event.target.files;
    if (!fileList.length) return;

    let image = fileList[0];
    showMessage(this.snackBar, 'Загрузка файла...');
    this.loadingFile = true;
    this.imageService.LoadFile(image).subscribe((res) => {
      showMessage(this.snackBar, 'Файл загружен');
      this.attach_files.push(res);
      this.loadingFile = false;
    });
  }

  getImage(img: any) {
    let abr = img.name.split('.').at(-1);
    let r = FILE_ICONS.get(abr);
    let url = 'other-icon.png';
    if (r) url = r;
    return `/assets/images/${url}`;
  }

  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }

  deleteFile(file: any) {
    const index = this.attach_files.findIndex((n) => n.token === file.token);
    if (index !== -1) {
      this.attach_files.splice(index, 1);
      this.deleteFiles.push(file);
    }
  }
}
