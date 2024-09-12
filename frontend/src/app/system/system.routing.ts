import { Routes, RouterModule } from '@angular/router';
import { SystemComponent } from './system.component';
import { AuthGuard } from '../shared/guards/auth.guard';
import { ProfileComponent } from './profile/profile.component';
import { NewsComponent } from './news/news.component';
import {
  ADMIN_PANEL_PAGE,
  ATTENDANCE_PAGE,
  MATERIALS_PAGE,
  MY_SCHEDULE_PAGE,
  NEWS_PAGE,
  PROFILE_PAGE,
  REPRESENTATIVE_PANEL_PAGE,
  SCHEDULE_REPRESENTATIVE_PAGE,
} from '../shared/consts';
import { AdminPanelComponent } from './admin-panel/admin-panel.component';
import { RepresentativePanelComponent } from './representative-panel/representative-panel.component';
import { MaterialsComponent } from './materials/materials.component';
import { ScheduleCommonComponent } from './schedule-common/schedule-common.component';
import { MyScheduleComponent } from './my-schedule/my-schedule.component';
import { AttendanceComponent } from './attendance/attendance.component';

const routes: Routes = [
  {
    path: '',
    component: SystemComponent,
    canActivate: [AuthGuard],
    children: [
      { path: `${PROFILE_PAGE}/:id`, component: ProfileComponent },
      { path: NEWS_PAGE, component: NewsComponent },
      { path: ADMIN_PANEL_PAGE, component: AdminPanelComponent },
      {
        path: REPRESENTATIVE_PANEL_PAGE,
        component: RepresentativePanelComponent,
      },
      { path: MATERIALS_PAGE, component: MaterialsComponent },
      {
        path: SCHEDULE_REPRESENTATIVE_PAGE,
        component: ScheduleCommonComponent,
      },
      { path: MY_SCHEDULE_PAGE, component: MyScheduleComponent },
      { path: ATTENDANCE_PAGE, component: AttendanceComponent },
    ],
  },
];

export const SystemRoutes = RouterModule.forChild(routes);
