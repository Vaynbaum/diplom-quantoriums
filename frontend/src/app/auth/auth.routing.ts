import { Routes, RouterModule } from '@angular/router';
import { SIGNIN_PAGE } from '../shared/consts';
import { SigninComponent } from './signin/signin.component';
import { RecoveryComponent } from './recovery/recovery.component';
import { ResetComponent } from './reset/reset.component';

const routes: Routes = [
  { path: SIGNIN_PAGE, component: SigninComponent },
  { path: 'recovery', component: RecoveryComponent },
  { path: 'reset', component: ResetComponent },
];

export const AuthRoutes = RouterModule.forChild(routes);
