import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SystemComponent } from './system.component';
import { RouterOutlet } from '@angular/router';
import { SharedModule } from '../shared/shared.module';
import { ProfileComponent } from './profile/profile.component';
import { SystemRoutes } from './system.routing';
import { NewsComponent } from './news/news.component';
import { AdminPanelComponent } from './admin-panel/admin-panel.component';
import { DialogAddRepresentativeComponent } from './dialog-add-representative/dialog-add-representative.component';
import { RepresentativePanelComponent } from './representative-panel/representative-panel.component';
import { DialogAddQuantoriumComponent } from './dialog-add-quantorium/dialog-add-quantorium.component';
import { DialogAddNewsComponent } from './dialog-add-news/dialog-add-news.component';
import { DialogAddQuantumComponent } from './dialog-add-quantum/dialog-add-quantum.component';
import { DialogAddTeacherComponent } from './dialog-add-teacher/dialog-add-teacher.component';
import { DialogAddStudentComponent } from './dialog-add-student/dialog-add-student.component';
import { DialogEditUserComponent } from './dialog-edit-user/dialog-edit-user.component';
import { DialogChangeQuantumComponent } from './dialog-change-quantum/dialog-change-quantum.component';
import { DialogChangeGroupComponent } from './dialog-change-group/dialog-change-group.component';
import { DialogAddQuantumLinkComponent } from './dialog-add-quantum-link/dialog-add-quantum-link.component';
import { MaterialsComponent } from './materials/materials.component';
import { DialogAddProjectComponent } from './dialog-add-project/dialog-add-project.component';
import { DialogProjectMoreComponent } from './dialog-project-more/dialog-project-more.component';
import { DialogAddProjectLinkComponent } from './dialog-add-project-link/dialog-add-project-link.component';
import { ScheduleCommonComponent } from './schedule-common/schedule-common.component';
import { MyScheduleComponent } from './my-schedule/my-schedule.component';
import { DialogAddScheduleItemComponent } from './dialog-add-schedule-item/dialog-add-schedule-item.component';
import { DialogMarkLessonComponent } from './dialog-mark-lesson/dialog-mark-lesson.component';
import { DialogReasonsMoreComponent } from './dialog-reasons-more/dialog-reasons-more.component';
import { DialogAddReasonComponent } from './dialog-add-reason/dialog-add-reason.component';
import { AttendanceComponent } from './attendance/attendance.component';

@NgModule({
  imports: [CommonModule, RouterOutlet, SystemRoutes, SharedModule],
  declarations: [
    SystemComponent,
    ProfileComponent,
    NewsComponent,
    AdminPanelComponent,
    RepresentativePanelComponent,
    DialogAddQuantoriumComponent,
    DialogAddRepresentativeComponent,
    DialogAddNewsComponent,
    DialogAddQuantumComponent,
    DialogAddTeacherComponent,
    DialogAddStudentComponent,
    DialogEditUserComponent,
    DialogChangeQuantumComponent,
    DialogChangeGroupComponent,
    DialogAddQuantumLinkComponent,
    DialogAddProjectComponent,
    DialogProjectMoreComponent,
    DialogAddProjectLinkComponent,
    DialogAddScheduleItemComponent,
    MaterialsComponent,
    ScheduleCommonComponent,
    DialogMarkLessonComponent,
    DialogReasonsMoreComponent,
    DialogAddReasonComponent,
    MyScheduleComponent,
    AttendanceComponent,
  ],
})
export class SystemModule {}
