import { UserStudentTeacherModel } from './../../shared/models/user.model';
import {
  DeletedGroupEvent,
  DeletedReasonEvent,
  GetedReasonEvent,
  GetedStudentsTeachersEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Injector, OnDestroy, OnInit } from '@angular/core';
import { FullUserModel } from '../../shared/models/user.model';
import { Observable } from 'rxjs';
import { profileInitialState } from '../../shared/store/profile.reducer';
import {
  ACCEPT_IMAGES,
  LINK_PAGE_PROFILE_SHORT,
  LINK_PAGE_REPRESENTATIVE_PANEL,
  NAME_REDUCER_PROFILE,
} from '../../shared/consts';
import { Store } from '@ngrx/store';
import {
  ImageService,
  LoadedImgGroupEvent,
  LoadedImgQuantoriumEvent,
  LoadedImgQuantumEvent,
  LoadedImgRoomEvent,
} from '../../shared/services/image.service';
import { getFullname, onOpenFileDialog, showMessage } from '../../shared/utils';
import { MatSnackBar } from '@angular/material/snack-bar';
import {
  DeletedUserEvent,
  UserService,
} from '../../shared/services/user.service';
import { MatDialog } from '@angular/material/dialog';
import { DialogAddNewsComponent } from '../dialog-add-news/dialog-add-news.component';
import { QuantumModel } from '../../shared/models/quantorium.model';
import { GroupModel } from '../../shared/models/group.model';
import { RoomModel } from '../../shared/models/room.model';
import { DialogAddQuantumComponent } from '../dialog-add-quantum/dialog-add-quantum.component';
import { ActivatedRoute, Params, Router } from '@angular/router';
import { DialogAddTeacherComponent } from '../dialog-add-teacher/dialog-add-teacher.component';
import { DialogAddStudentComponent } from '../dialog-add-student/dialog-add-student.component';
import { DialogChangeQuantumComponent } from '../dialog-change-quantum/dialog-change-quantum.component';
import { DialogChangeGroupComponent } from '../dialog-change-group/dialog-change-group.component';
import { FormControl } from '@angular/forms';
import { DialogAddQuantumLinkComponent } from '../dialog-add-quantum-link/dialog-add-quantum-link.component';
import { ReasonModel } from '../../shared/models/reason.model';
import { DialogAddReasonComponent } from '../dialog-add-reason/dialog-add-reason.component';

@Component({
  selector: 'app-representative-panel',
  templateUrl: './representative-panel.component.html',
  styleUrls: ['./representative-panel.component.scss'],
})
export class RepresentativePanelComponent implements OnInit, OnDestroy {
  acceptImages = ACCEPT_IMAGES;
  li: any;
  groups: GroupModel[] = [];
  quantums: QuantumModel[] = [];
  rooms: RoomModel[] = [];
  reasons: ReasonModel[] = [];
  ps: any;
  teachers: UserStudentTeacherModel[] = [];
  teacherValue = '';
  deletingTeacher = false;

  students: UserStudentTeacherModel[] = [];
  studentValue = '';
  deletingStudent = false;
  selected = new FormControl(0);
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);

  constructor(
    private store: Store<{ profile: FullUserModel }>,
    private userService: UserService,
    private quantoriumService: QuantoriumService,
    private injector: Injector,
    public dialog: MatDialog,
    private snackBar: MatSnackBar,
    private route: ActivatedRoute,
    private router: Router,
    private imageService: ImageService
  ) {}
  ngOnDestroy(): void {
    this.li.unsubscribe();
    this.ps.unsubscribe();
    this.liq.unsubscribe();
    this.lir.unsubscribe();
    this.gst.unsubscribe();
    this.du.unsubscribe();
    this.lig.unsubscribe();
    this.gr.unsubscribe();
  }
  liq: any;
  lir: any;
  gst: any;
  du: any;
  lig: any;
  gr: any;
  ngOnInit() {
    this.route.queryParams.subscribe((params: Params) => {
      this.selected.setValue(Number(params['tab']));
    });

    this.li = LoadedImgQuantoriumEvent.subscribe(() => {
      this.userService.GetUserProfile();
    });
    DeletedReasonEvent.subscribe(() => this.getReasons());

    this.du = DeletedUserEvent.subscribe((res) => {
      if (this.deletingTeacher) {
        this.deletingTeacher = false;
        this.getTeachers();
      } else if (this.deletingStudent) {
        this.deletingStudent = false;
        this.getStudents();
        this.getGroups();
      }
    });

    this.liq = LoadedImgQuantumEvent.subscribe(() => this.getQuantums());
    this.liq = DeletedGroupEvent.subscribe(() => this.getGroups());
    this.lir = LoadedImgRoomEvent.subscribe(() => this.getRooms());
    this.lig = LoadedImgGroupEvent.subscribe(() => this.getGroups());

    this.gst = GetedStudentsTeachersEvent.subscribe((res) => {
      if (res.is_teacher) this.teachers = res.res;
      else this.students = res.res;
    });
    this.gr = GetedReasonEvent.subscribe((reasons) => (this.reasons = reasons));

    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
      this.getObjectQuantorium();
    });
  }
  getReasons() {
    this.quantoriumService.GetReasons();
  }
  getObjectQuantorium() {
    if (this.profile.id != -1) {
      this.getQuantums();
      this.getRooms();
      this.getGroups();
      this.getTeachers();
      this.getStudents();
      this.getReasons();
    }
  }
  getTeachers() {
    this.quantoriumService.GetTeachersStudents({
      student_or_teacher: true,
      lastname: this.teacherValue,
    });
  }

  getStudents() {
    this.quantoriumService.GetTeachersStudents({
      student_or_teacher: false,
      lastname: this.studentValue,
    });
  }
  getGroups() {
    this.quantoriumService
      .GetGroups(this.profile.representative?.quantorium_id)
      .subscribe((items) => {
        this.groups = items;
      });
  }
  getQuantums() {
    this.quantoriumService
      .GetQuantums(this.profile.representative?.quantorium_id)
      .subscribe((items) => {
        this.quantums = items;
      });
  }
  getRooms() {
    this.quantoriumService
      .GetRooms(this.profile.representative?.quantorium_id)
      .subscribe((items) => {
        this.rooms = items;
      });
  }

  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }

  fileChange(event: any, type: string, id?: number) {
    let fileList: FileList = event.target.files;
    if (!fileList.length) return;

    let image = fileList[0];
    if (this.profile) {
      showMessage(this.snackBar, 'Загрузка изображения...');
      if (type == 'quantorium')
        this.imageService.LoadQuantoriumImg({
          u_id: id,
          file: image,
        });
      else if (type == 'quantum')
        this.imageService.LoadQuantumImg({
          u_id: id,
          file: image,
        });
      else if (type == 'room')
        this.imageService.LoadRoomImg({
          u_id: id,
          file: image,
        });
      else if (type == 'group')
        this.imageService.LoadGroupImg({
          u_id: id,
          file: image,
        });
    }
  }
  compileId(name: string, index: number) {
    return `file-${name}-${index}`;
  }
  onOpenFileDialog(name: string) {
    onOpenFileDialog(name);
  }

  addNews() {
    this.dialog.open(DialogAddNewsComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { isEdit: false },
    });
  }

  addQuantum() {
    const r = this.dialog.open(DialogAddQuantumComponent, {
      injector: this.injector,
      maxWidth: '500px',
      width: '95vw',
      data: { is_quantum: true, isEdit: false },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.getQuantums();
    });
  }

  addGroup() {
    const r = this.dialog.open(DialogAddQuantumComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { is_group: true, isEdit: false },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.getGroups();
    });
  }
  editGroup(group: GroupModel) {
    const r = this.dialog.open(DialogAddQuantumComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { is_group: true, isEdit: true, group: group },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.getGroups();
    });
  }
  addRoom() {
    const r = this.dialog.open(DialogAddQuantumComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { is_room: true, isEdit: false },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.getRooms();
    });
  }

  deleteTeacher(user: UserStudentTeacherModel) {
    this.deletingTeacher = true;
    this.userService.DeleteUser(user.id);
  }

  getFullname(p: UserStudentTeacherModel) {
    return getFullname(p);
  }
  goToUser(user: UserStudentTeacherModel) {
    this.router.navigate([`${LINK_PAGE_PROFILE_SHORT}/${user.id}`]);
  }

  addTeacher() {
    const r = this.dialog.open(DialogAddTeacherComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { quantums: this.quantums },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.getTeachers();
    });
  }
  addStudent() {
    const r = this.dialog.open(DialogAddStudentComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { groups: this.groups },
    });
    r.afterClosed().subscribe((res) => {
      if (res) {
        this.getStudents();
        this.getGroups();
      }
    });
  }
  deleteStudent(user: UserStudentTeacherModel) {
    this.deletingStudent = true;
    this.userService.DeleteUser(user.id);
  }

  deleteGroup(group: GroupModel) {
    this.quantoriumService.DeleteGroup(group.id);
  }

  changeQuantum(user: UserStudentTeacherModel) {
    const r = this.dialog.open(DialogChangeQuantumComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { user: user, quantums: this.quantums },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.getTeachers();
    });
  }

  changeGroup(user: UserStudentTeacherModel) {
    const r = this.dialog.open(DialogChangeGroupComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { user: user, groups: this.groups },
    });
    r.afterClosed().subscribe((res) => {
      if (res) {
        this.getStudents();
        this.getGroups();
      }
    });
  }

  selectedIndex(event: any) {
    this.selected.setValue(event);
    this.router.navigate([`${LINK_PAGE_REPRESENTATIVE_PANEL}/`], {
      queryParams: { tab: event },
    });
  }
  addQuantumLink(user: UserStudentTeacherModel) {
    this.dialog.open(DialogAddQuantumLinkComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { user: user, quantums: this.quantums },
    });
  }

  clearValueTeacher() {
    this.teacherValue = '';
    this.getTeachers();
  }

  onKeyupTeacher() {
    this.getTeachers();
  }

  clearValueStudent() {
    this.studentValue = '';
    this.getStudents();
  }

  onKeyupStudent() {
    this.getStudents();
  }

  addReason() {
    let r = this.dialog.open(DialogAddReasonComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { quantorium_id: this.profile.representative?.quantorium_id },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.getReasons();
    });
  }
  deleteReason(reason: ReasonModel) {
    this.quantoriumService.DeleteReason(reason.id);
  }
}
