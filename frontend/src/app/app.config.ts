import { provideRouter } from '@angular/router';
import {
  ApplicationConfig,
  LOCALE_ID,
  importProvidersFrom,
} from '@angular/core';
import { routes } from './app.routes';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { HttpClientModule } from '@angular/common/http';
import { AuthGuard } from './shared/guards/auth.guard';
import { httpInterceptorProviders } from './shared/http-interceptors';
import { provideState, provideStore } from '@ngrx/store';
import { NAME_REDUCER_PROFILE } from './shared/consts';
import { profileReducer } from './shared/store/profile.reducer';
import localeRu from '@angular/common/locales/ru';
import { registerLocaleData } from '@angular/common';
registerLocaleData(localeRu, 'ru');

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideAnimationsAsync(),
    importProvidersFrom(HttpClientModule),
    httpInterceptorProviders,
    AuthGuard,
    provideStore(),
    provideState({ name: NAME_REDUCER_PROFILE, reducer: profileReducer }),
    { provide: LOCALE_ID, useValue: 'ru' },
  ],
};
