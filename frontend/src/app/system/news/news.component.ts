import { Observable } from 'rxjs';
import { NewsModel } from '../../shared/models/news.model';
import { FullUserModel } from '../../shared/models/user.model';
import { profileInitialState } from '../../shared/store/profile.reducer';
import {
  DeletedNewsEvent,
  EditedNewsEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import {
  Component,
  ElementRef,
  Injector,
  OnDestroy,
  OnInit,
  ViewChild,
} from '@angular/core';
import {
  ADMIN_ROLE,
  FORMAT_DATE,
  LOCALE_RU,
  NAME_REDUCER_PROFILE,
  REPRESENTATIVE_ROLE,
} from '../../shared/consts';
import { Store } from '@ngrx/store';
import { ImageService } from '../../shared/services/image.service';
import { formatDate } from '@angular/common';
import { MatDialog } from '@angular/material/dialog';
import { DialogAddNewsComponent } from '../dialog-add-news/dialog-add-news.component';

@Component({
  selector: 'app-news',
  templateUrl: './news.component.html',
  styleUrls: ['./news.component.scss'],
})
export class NewsComponent implements OnInit, OnDestroy {
  value = '';
  day: Date | null = null;
  @ViewChild('dateInput') dateInput: ElementRef<HTMLInputElement> | undefined;

  profile: FullUserModel = profileInitialState;
  profile$: Observable<FullUserModel> = this.store.select(NAME_REDUCER_PROFILE);
  ps: any;
  needLoad = true;
  title = 'Новости';
  constructor(
    private quantoriumService: QuantoriumService,
    private injector: Injector,
    public dialog: MatDialog,
    private imageService: ImageService,
    private store: Store<{ profile: FullUserModel }>
  ) {}
  ngOnDestroy(): void {
    this.ps.unsubscribe();
    this.dn.unsubscribe();
    this.en.unsubscribe();
    this.news = [];
    this.needLoad = true;
  }
  dn: any;
  en: any;
  news: NewsModel[] = [];
  ngOnInit() {
    this.ps = this.profile$.subscribe((profile) => {
      this.profile = profile;
      if (this.profile.id != -1) this.getNews();
    });

    this.dn = DeletedNewsEvent.subscribe(() => this.getNews());
    this.en = EditedNewsEvent.subscribe(() => this.getNews());
  }

  getNews(next = false) {
    let qid = -1;
    let p = this.profile;
    if (p.role_id == ADMIN_ROLE || !this.needLoad) return;

    if (p.representative) qid = p.representative.quantorium_id;
    if (p.teacher) qid = p.teacher.quantorium_id;
    if (p.student) qid = p.student.quantorium_id;

    let b = null;
    if (this.day) b = formatDate(this.day, FORMAT_DATE, LOCALE_RU);

    this.quantoriumService.GetNews(qid, b, this.value).subscribe((items) => {
      if (next) {
        items.forEach((n) => {
          if (!this.news.find((ne) => ne.id == n.id)) this.news.push(n);
        });
      } else {
        this.news = items;
      }

      if (items.length == 0) this.needLoad = false;
      else this.needLoad = true;
    });
  }

  compileUrl(news: NewsModel) {
    return this.imageService.getImg(news.img);
  }

  clearValue() {
    this.value = '';
    this.needLoad = true;
    this.getNews();
  }

  onKeyup() {
    this.needLoad = true;
    this.getNews();
  }

  onDateChange(event: any) {
    this.needLoad = true;
    this.day = event._d;
    this.getNews();
  }

  isCanEdit() {
    return this.profile.role_id == REPRESENTATIVE_ROLE;
  }

  reset() {
    this.day = null;
    this.needLoad = true;
    if (this.dateInput) this.dateInput.nativeElement.value = '';
    this.value = '';
    this.getNews();
  }
  deleteNews(news: NewsModel) {
    this.quantoriumService.DeleteNews(news.id);
  }
  editNews(news: NewsModel) {
    this.dialog.open(DialogAddNewsComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: { news: news, isEdit: true },
    });
  }
}
