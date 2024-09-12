import {
  DeletedUserEvent,
  UserService,
} from './../../shared/services/user.service';
import { DialogAddRepresentativeComponent } from './../dialog-add-representative/dialog-add-representative.component';
import { Observable } from 'rxjs';
import { QuantoriumWithRepresentativesModel } from '../../shared/models/quantorium.model';
import {
  FullUserModel,
  RepresentativeWithUserModel,
} from '../../shared/models/user.model';
import { ImageService } from '../../shared/services/image.service';
import {
  GetedQuantorumsEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Injector, OnDestroy, OnInit } from '@angular/core';
import { profileInitialState } from '../../shared/store/profile.reducer';
import { Store } from '@ngrx/store';
import {
  LINK_PAGE_ADMIN_PANEL,
  LINK_PAGE_PROFILE_SHORT,
  NAME_REDUCER_PROFILE,
} from '../../shared/consts';
import { MatDialog } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { DialogAddQuantoriumComponent } from '../dialog-add-quantorium/dialog-add-quantorium.component';
import { FormControl } from '@angular/forms';
import { DialogReasonsMoreComponent } from '../dialog-reasons-more/dialog-reasons-more.component';

@Component({
  selector: 'app-admin-panel',
  templateUrl: './admin-panel.component.html',
  styleUrls: ['./admin-panel.component.scss'],
})
export class AdminPanelComponent implements OnInit, OnDestroy {
  selected = new FormControl(0);
  ps: any;
  quantoriums: QuantoriumWithRepresentativesModel[] = [];
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  constructor(
    private quantoriumService: QuantoriumService,
    private imageService: ImageService,
    private userService: UserService,
    private injector: Injector,
    private router: Router,
    public dialog: MatDialog,
    private store: Store<{ profile: FullUserModel }>
  ) {}
  ngOnDestroy(): void {
    this.ps.unsubscribe();
  }

  ngOnInit() {
    GetedQuantorumsEvent.subscribe((res) => {
      this.quantoriums = res;
    });
    DeletedUserEvent.subscribe((res) => {
      this.quantoriumService.GetQuantoriums();
    });
    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
      if (this.profile.id != -1) this.quantoriumService.GetQuantoriums();
    });
  }

  getFullname(p: RepresentativeWithUserModel) {
    return `${p.user.lastname} ${p.user.firstname} ${p.patronymic}`;
  }
  goToUser(user: RepresentativeWithUserModel) {
    this.router.navigate([`${LINK_PAGE_PROFILE_SHORT}/${user.user_id}`]);
  }

  compileUrl(p: RepresentativeWithUserModel) {
    return this.imageService.getImg(p.user.img);
  }
  compileUrlQ(img: object) {
    return this.imageService.getImg(img);
  }
  addRepresentative(quantorium: QuantoriumWithRepresentativesModel) {
    const dialogRef = this.dialog.open(DialogAddRepresentativeComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { quantoriumId: quantorium.id },
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result) this.quantoriumService.GetQuantoriums();
    });
  }

  deleteUser(user: RepresentativeWithUserModel) {
    this.userService.DeleteUser(user.user_id);
  }

  addQuantorium() {
    const dialogRef = this.dialog.open(DialogAddQuantoriumComponent, {
      injector: this.injector,
      maxWidth: '500px',
      width: '95vw',
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result) this.quantoriumService.GetQuantoriums();
    });
  }

  selectedIndex(event: any) {
    this.selected.setValue(event);
    this.router.navigate([`${LINK_PAGE_ADMIN_PANEL}/`], {
      queryParams: { tab: event },
    });
  }
  showReasons() {
    const dialogRef = this.dialog.open(DialogReasonsMoreComponent, {
      injector: this.injector,
      maxWidth: '500px',
      width: '95vw',
    });
  }
}
