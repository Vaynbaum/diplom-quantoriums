import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDividerModule } from '@angular/material/divider';
import { MatButtonModule } from '@angular/material/button';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { HeaderComponent } from './components/header/header.component';
import { MatMenuModule } from '@angular/material/menu';
import { RouterModule } from '@angular/router';
import { NotFoundComponent } from '../not-found/not-found.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatListModule } from '@angular/material/list';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatDialogModule } from '@angular/material/dialog';
import { MatTabsModule } from '@angular/material/tabs';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatSelectModule } from '@angular/material/select';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatCardModule } from '@angular/material/card';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatTableModule } from '@angular/material/table';
@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatInputModule,
    MatFormFieldModule,
    RouterModule,
    MatDividerModule,
    MatButtonModule,
    MatIconModule,
    MatSnackBarModule,
    MatMenuModule,
    MatDatepickerModule,
    MatListModule,
    MatExpansionModule,
    MatDialogModule,
    MatTabsModule,
    MatTooltipModule,
    MatSelectModule,
    MatSlideToggleModule,
    MatCardModule,
    MatAutocompleteModule,
    MatTableModule,
  ],
  exports: [
    FormsModule,
    ReactiveFormsModule,
    MatInputModule,
    MatFormFieldModule,
    MatDividerModule,
    RouterModule,
    MatButtonModule,
    MatIconModule,
    MatSnackBarModule,
    HeaderComponent,
    MatMenuModule,
    NotFoundComponent,
    MatDatepickerModule,
    MatListModule,
    MatExpansionModule,
    MatDialogModule,
    MatTooltipModule,
    MatTabsModule,
    MatSelectModule,
    MatSlideToggleModule,
    MatCardModule,
    MatAutocompleteModule,
    MatTableModule,
  ],
  declarations: [HeaderComponent, NotFoundComponent],
})
export class SharedModule {}
