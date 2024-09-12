import { FullUserModel } from '../models/user.model';
import { createReducer, on } from '@ngrx/store';
import { loadProfileSuccess, logout } from './profile.actions';

export const profileInitialState = new FullUserModel(
  -1,
  '',
  '',
  '',
  null,
  new Date(),
  -1,
  null,
  null,
  null,
  null,
  null
);
export const profileReducer = createReducer(
  profileInitialState,
  on(logout, (state) => profileInitialState),
  on(loadProfileSuccess, (state, { profile }) => profile)
);
