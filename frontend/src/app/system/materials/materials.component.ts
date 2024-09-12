import {
  DeletedProjectEvent,
  GetedMaterialsEvent,
  GetedProjectsEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import {
  DeletedMaterialEvent,
  ImageService,
  LoadedImgProjectEvent,
  LoadedMaterialEvent,
} from './../../shared/services/image.service';
import { Component, Injector, OnDestroy, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import {
  FullUserModel,
  StudentUserModel,
  TeacherUserModel,
} from '../../shared/models/user.model';
import { profileInitialState } from '../../shared/store/profile.reducer';
import { Observable } from 'rxjs';
import {
  ACCEPT_IMAGES,
  FILE_ICONS,
  LINK_PAGE_PROFILE_SHORT,
  NAME_REDUCER_PROFILE,
  STUDENT_ROLE,
  TEACHER_ROLE,
} from '../../shared/consts';
import { onOpenFileDialog, showMessage } from '../../shared/utils';
import { MatSnackBar } from '@angular/material/snack-bar';
import { UserService } from '../../shared/services/user.service';
import { Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { DialogAddProjectComponent } from '../dialog-add-project/dialog-add-project.component';
import { DialogProjectMoreComponent } from '../dialog-project-more/dialog-project-more.component';
import {
  ProjectModel,
  ProjectStudentModel,
} from '../../shared/models/project.model';
import { MaterialTeacherModel } from '../../shared/models/material.model';
import { DialogAddProjectLinkComponent } from '../dialog-add-project-link/dialog-add-project-link.component';

@Component({
  selector: 'app-materials',
  templateUrl: './materials.component.html',
  styleUrls: ['./materials.component.scss'],
})
export class MaterialsComponent implements OnInit, OnDestroy {
  acceptImages = ACCEPT_IMAGES;
  inputFileId = 'file-input';
  inputImgId = 'file-input-img';
  myMaterials = '';
  allMaterials = '';
  addMaterial = '';
  materials: MaterialTeacherModel[] = [];
  projects: ProjectStudentModel[] = [];
  ps: any;
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  constructor(
    private store: Store<{ profile: FullUserModel }>,
    private snackBar: MatSnackBar,
    private userService: UserService,
    private injector: Injector,
    public dialog: MatDialog,
    private router: Router,
    private quantoriumService: QuantoriumService,
    private imageService: ImageService
  ) {}
  ngOnDestroy(): void {
    this.ps.unsubscribe();
    this.lm.unsubscribe();
    this.dm.unsubscribe();
    this.gm.unsubscribe();
    this.dp.unsubscribe();
    this.lip.unsubscribe();
    this.gp.unsubscribe();
  }
  lm: any;
  dm: any;
  dp: any;
  gm: any;
  gp: any;
  lip: any;
  ngOnInit() {
    this.lm = LoadedMaterialEvent.subscribe(() =>
      this.userService.GetUserProfile()
    );
    this.dm = DeletedMaterialEvent.subscribe(() =>
      this.userService.GetUserProfile()
    );
    this.dp = DeletedProjectEvent.subscribe(() =>
      this.userService.GetUserProfile()
    );
    this.gm = GetedMaterialsEvent.subscribe((res) => {
      this.materials = res;
    });
    this.gp = GetedProjectsEvent.subscribe((res) => {
      this.projects = res;
    });
    this.lip = LoadedImgProjectEvent.subscribe(() =>
      this.userService.GetUserProfile()
    );

    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
      if (this.profile.id != -1) {
        if (this.profile.role_id == STUDENT_ROLE) {
          this.myMaterials = 'Мои проекты';
          this.allMaterials = 'Материалы';
          this.addMaterial = 'добавить проект';
          this.quantoriumService.GetMaterials();
        } else if (this.profile.role_id == TEACHER_ROLE) {
          this.myMaterials = 'Мои материалы';
          this.allMaterials = 'Проекты';
          this.addMaterial = 'добавить файл';
          this.quantoriumService.GetProjects();
        }
      }
    });
  }
  addMaterialItem() {
    if (this.profile.role_id == STUDENT_ROLE) {
      const r = this.dialog.open(DialogAddProjectComponent, {
        maxWidth: '500px',
        injector: this.injector,
        width: '95vw',
        data: { quantums: this.profile.student?.quantum_links, isEdit: false },
      });
      r.afterClosed().subscribe((res) => {
        if (res) this.userService.GetUserProfile();
      });
    } else if (this.profile.role_id == TEACHER_ROLE)
      onOpenFileDialog(this.inputFileId);
  }

  onOpenFileDialog(name: string) {
    onOpenFileDialog(name);
  }

  fileChange(event: any) {
    let fileList: FileList = event.target.files;
    if (!fileList.length) return;

    let image = fileList[0];
    if (this.profile) {
      showMessage(this.snackBar, 'Загрузка файла...');
      this.imageService.LoadMaterial(image);
    }
  }
  fileChangeImg(event: any, project_id: number) {
    let fileList: FileList = event.target.files;
    if (!fileList.length) return;

    let image = fileList[0];
    if (this.profile) {
      showMessage(this.snackBar, 'Загрузка изображения...');
      this.imageService.LoadProjectImg({ u_id: project_id, file: image });
    }
  }

  getImage(img: any) {
    let abr = img.name.split('.').at(-1);
    let r = FILE_ICONS.get(abr);
    let url = 'other-icon.png';
    if (r) url = r;
    return `/assets/images/${url}`;
  }

  compileUrl(img: object | null) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }

  redirectLink(url: string) {
    let c_url = this.imageService.getImg(url);
    if (c_url) window.open(c_url, '_blank');
  }

  deleteMaterial(id: number) {
    if (this.profile.role_id == STUDENT_ROLE) {
      this.quantoriumService.DeleteProject(id);
    } else if (this.profile.role_id == TEACHER_ROLE)
      this.imageService.DeleteMaterial(id);
  }

  getFullnameTeacher(teacher: TeacherUserModel | StudentUserModel) {
    return `${teacher.user.lastname} ${teacher.user.firstname[0]}. ${teacher.patronymic[0]}.`;
  }

  goToUser(user: TeacherUserModel | StudentUserModel) {
    this.router.navigate([`${LINK_PAGE_PROFILE_SHORT}/${user.user_id}`]);
  }
  openProject(project: ProjectModel) {
    this.dialog.open(DialogProjectMoreComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { profile: this.profile, project: project },
    });
  }

  addProjectLink(project_id: number) {
    this.dialog.open(DialogAddProjectLinkComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: {
        project_id: project_id,
        group_id: this.profile.student?.group_id,
      },
    });
  }

  isOwnerProject(project: ProjectModel) {
    return this.profile.id == project.student_id;
  }

  editProject(project: ProjectModel) {
    const r = this.dialog.open(DialogAddProjectComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { isEdit: true, project: project },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.userService.GetUserProfile();
    });
  }
}
