import { createAction, props } from '@ngrx/store';
import { FullUserModel } from '../models/user.model';
export const loadProfileSuccess = createAction(
  '[User Service] Load Profile Success',
  props<{ profile: FullUserModel }>()
);
export const getAvatarSuccess = createAction(
  '[Image Service] Get Avatar Success',
  props<{ image: string }>()
);
export const logout = createAction('[Header Component] Logout');
