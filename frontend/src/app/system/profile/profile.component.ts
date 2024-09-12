import {
  DeletedStudentQuntumEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import {
  ImageService,
  LoadedImgUserEvent,
} from './../../shared/services/image.service';
import { Component, Injector, OnDestroy, OnInit } from '@angular/core';
import {
  GetedUserProfileEvent,
  UserService,
} from '../../shared/services/user.service';
import { ActivatedRoute, Params, Router } from '@angular/router';
import {
  FullUserModel,
  QuantumLinksModel,
} from '../../shared/models/user.model';
import { Store } from '@ngrx/store';
import { profileInitialState } from '../../shared/store/profile.reducer';
import { Observable } from 'rxjs';
import {
  ACCEPT_IMAGES,
  ADMIN_ROLE,
  LINK_PAGE_PROFILE_SHORT,
  ME,
  NAME_REDUCER_PROFILE,
  REPRESENTATIVE_ROLE,
  STUDENT_ROLE,
  TEACHER_ROLE,
} from '../../shared/consts';
import { getFullname, onOpenFileDialog, showMessage } from '../../shared/utils';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatDialog } from '@angular/material/dialog';
import { DialogEditUserComponent } from '../dialog-edit-user/dialog-edit-user.component';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit, OnDestroy {
  acceptImages = ACCEPT_IMAGES;
  title = 'Основная информация';
  contactTitle = 'Контакты';
  emailTitle = 'Email';
  isStudent = false;
  phoneTitle = 'Телефон';
  groupTitle = 'Группа';
  birthdayTitle = 'Дата рождения';
  roleTitle = 'Роль';
  quantumTitle = 'Квантум';
  quantumsTitle = 'Квантумы';
  createdAtTitle = 'В системе с';
  id?: string | number;
  myProfile: FullUserModel = profileInitialState;
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  constructor(
    private store: Store<{ profile: FullUserModel }>,
    private router: Router,
    private userService: UserService,
    private snackBar: MatSnackBar,
    private injector: Injector,
    public dialog: MatDialog,
    private imageService: ImageService,
    private quantoriumService: QuantoriumService,
    private route: ActivatedRoute
  ) {}
  ngOnDestroy(): void {
    this.gu.unsubscribe();
    this.ps.unsubscribe();
    this.li.unsubscribe();
    this.ds.unsubscribe();
  }
  gu: any;
  ps: any;
  li: any;
  ds: any;
  ngOnInit() {
    this.gu = GetedUserProfileEvent.subscribe((profile: FullUserModel) => {
      this.profile = profile;
      this.showBeautifulId(this.id);
      if (this.profile.student)
        this.isStudent = this.profile.student.quantum_links.length > 0;
      else this.isStudent = false;
    });

    this.li = LoadedImgUserEvent.subscribe(() => {
      this.userService.GetUserProfile(this.id);
    });

    this.ds = DeletedStudentQuntumEvent.subscribe(() => {
      this.userService.GetUserProfile(this.id);
    });

    this.ps = this.profile$.subscribe((profile) => {
      this.myProfile = profile;
    });

    this.route.params.subscribe((params: Params) => {
      this.id = params['id'];
      this.userService.GetUserProfile(this.id);
    });
  }

  getFullname() {
    return getFullname(this.profile);
  }

  getPhone() {
    let phone = null;
    let p = this.profile;

    if (p.representative) phone = p.representative?.phone;
    else if (p.teacher) phone = p.teacher?.phone;
    else if (p.student) phone = p.student?.phone;
    return phone;
  }
  fileChange(event: any) {
    let fileList: FileList = event.target.files;
    if (!fileList.length) return;

    let image = fileList[0];
    if (this.profile) {
      showMessage(this.snackBar, 'Загрузка изображения...');
      this.imageService.LoadUserImg({
        u_id: this.profile.id === this.myProfile.id ? null : this.profile.id,
        file: image,
      });
    }
  }

  onOpenFileDialog(name: string) {
    if (this.canChangeImg()) onOpenFileDialog(name);
  }

  getQuantorium() {
    let quantorium = null;
    let p = this.profile;

    if (p.representative) quantorium = p.representative?.quantorium.address;
    else if (p.teacher) quantorium = p.teacher?.quantorium.address;
    else if (p.student) quantorium = p.student?.quantorium.address;
    return quantorium;
  }

  getGroup() {
    let group = null;
    if (this.profile.student) group = this.profile.student.group.name;
    return group;
  }

  getQuantum() {
    let quantum = null;
    if (this.profile.teacher) quantum = this.profile.teacher.quantum.name;
    return quantum;
  }

  getBirthdate() {
    let birthdate = null;
    if (this.profile.student) birthdate = this.profile.student.birthdate;
    if (this.profile.teacher) birthdate = this.profile.teacher.birthdate;
    return birthdate;
  }

  getQuantoriumTitle() {
    let title = 'Место работы';
    if (this.profile.student) title = 'Место учебы';
    return title;
  }

  showBeautifulId(id?: string | number) {
    let idIsMe = id == ME;
    if (idIsMe && this.profile.id != -1) {
      let url = `${LINK_PAGE_PROFILE_SHORT}/${this.profile.id}`;
      this.router.navigate([url]);
    }
  }

  compileUrl(img: object | null) {
    return this.imageService.getImg(img);
  }

  canChangeImg() {
    return (
      this.myProfile.role_id == ADMIN_ROLE ||
      this.myProfile.role_id == REPRESENTATIVE_ROLE
    );
  }

  canDeleteQuantum() {
    return this.myProfile.role_id == REPRESENTATIVE_ROLE;
  }

  canEdit() {
    return (
      this.myProfile.role_id == REPRESENTATIVE_ROLE &&
      (this.profile.role_id == STUDENT_ROLE ||
        this.profile.role_id == TEACHER_ROLE ||
        this.profile.id == this.myProfile.id)
    );
  }

  imgStyle() {
    let style: any = {};
    if (this.canChangeImg()) style.cursor = 'pointer';
    return style;
  }

  editUser() {
    const r = this.dialog.open(DialogEditUserComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: {
        profile: this.profile,
        isMy: this.profile.id == this.myProfile.id,
      },
    });
    r.afterClosed().subscribe((res) => {
      this.userService.GetUserProfile(this.id);
    });
  }

  getStatusQuantum(link: QuantumLinksModel) {
    return link.is_free ? 'бесплатно' : 'платно';
  }

  getStyleQuantum(link: QuantumLinksModel) {
    if (link.is_free) return { color: 'green' };
    return {};
  }

  deleteLink(link: QuantumLinksModel) {
    this.quantoriumService.DeleteStudentQuantum({
      student_id: this.profile.id,
      quantum_id: link.quantum_id,
    });
  }

  getTooltip() {
    if (this.canChangeImg()) return 'Загружайте картинки в формате 1:1';
    return '';
  }
}
