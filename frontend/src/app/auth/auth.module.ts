import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthComponent } from './auth.component';
import { RouterOutlet } from '@angular/router';
import { SharedModule } from '../shared/shared.module';
import { SigninComponent } from './signin/signin.component';
import { AuthRoutes } from './auth.routing';
import { RecoveryComponent } from './recovery/recovery.component';
import { ResetComponent } from './reset/reset.component';

@NgModule({
  imports: [CommonModule, RouterOutlet, AuthRoutes, SharedModule],
  declarations: [
    AuthComponent,
    SigninComponent,
    ResetComponent,
    RecoveryComponent,
  ],
})
export class AuthModule {}
