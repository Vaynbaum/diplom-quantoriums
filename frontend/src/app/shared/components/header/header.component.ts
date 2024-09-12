import { Component, OnDestroy, OnInit } from '@angular/core';
import { FullUserModel } from '../../models/user.model';
import { Observable } from 'rxjs';
import { profileInitialState } from '../../store/profile.reducer';
import { Store } from '@ngrx/store';
import {
  ADMIN_ROLE,
  LINK_PAGE_ADMIN_PANEL,
  LINK_PAGE_ATTENDANCE,
  LINK_PAGE_MATERIALS,
  LINK_PAGE_MY_SCHEDULE,
  LINK_PAGE_NEWS,
  LINK_PAGE_PROFILE,
  LINK_PAGE_REPRESENTATIVE_PANEL,
  LINK_PAGE_SCHEDULE_REPRESENTATIVE,
  LINK_PAGE_SIGNIN,
  NAME_REDUCER_PROFILE,
  REPRESENTATIVE_ROLE,
  STUDENT_ROLE,
  TEACHER_ROLE,
} from '../../consts';
import { getFullname } from '../../utils';
import { ImageService } from '../../services/image.service';
import { Router } from '@angular/router';
import { logout } from '../../store/profile.actions';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
})
export class HeaderComponent implements OnInit, OnDestroy {
  fio = 'Иванов Иван';
  role = 'ученик';

  menuBtns = [
    {
      title: 'Профиль',
      link: LINK_PAGE_PROFILE,
      show: () => {
        return true;
      },
    },
    {
      title: 'Панель администратора',
      link: LINK_PAGE_ADMIN_PANEL,
      show: () => {
        return !this.checkUser();
      },
    },
    {
      title: 'Панель представителя',
      link: LINK_PAGE_REPRESENTATIVE_PANEL,
      show: () => {
        return this.checkRepresenative();
      },
    },
    {
      title: 'Новости',
      link: LINK_PAGE_NEWS,
      show: () => {
        return this.checkUser();
      },
    },
    {
      title: 'Расписание',
      link: LINK_PAGE_SCHEDULE_REPRESENTATIVE,
      show: () => {
        return this.checkTR();
      },
    },
    {
      title: 'Мое расписание',
      link: LINK_PAGE_MY_SCHEDULE,
      show: () => {
        return this.checkST();
      },
    },
    {
      title: 'Посещаемость',
      link: LINK_PAGE_ATTENDANCE,
      show: () => {
        return this.checkTR();
      },
    },
    {
      title: 'Учебные материалы',
      link: LINK_PAGE_MATERIALS,
      show: () => {
        return this.checkST();
      },
    },
  ];
  exitBtn = { title: 'Выход', icon: 'logout' };
  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  constructor(
    private store: Store<{ profile: FullUserModel }>,
    private authService: AuthService,
    private router: Router,
    private imageService: ImageService
  ) {}
  ngOnDestroy(): void {
    this.ps.unsubscribe();
  }
  ps: any;
  ngOnInit() {
    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
    });
  }

  checkUser() {
    if (this.profile && this.profile.role_id == ADMIN_ROLE) return false;
    return true;
  }
  checkRepresenative() {
    return this.profile.role_id == REPRESENTATIVE_ROLE;
  }
  checkTR() {
    return (
      this.profile.role_id == REPRESENTATIVE_ROLE ||
      this.profile.role_id == TEACHER_ROLE
    );
  }
  checkST() {
    return (
      this.profile.role_id == STUDENT_ROLE ||
      this.profile.role_id == TEACHER_ROLE
    );
  }

  getFullname() {
    return getFullname(this.profile);
  }

  compileUrl() {
    return this.imageService.getImg(this.profile.img);
  }

  logout() {
    this.authService.DeleteTokens();
    this.store.dispatch(logout());
    this.router.navigate([LINK_PAGE_SIGNIN], {
      queryParams: { logoutSuccess: true },
    });
  }
}
