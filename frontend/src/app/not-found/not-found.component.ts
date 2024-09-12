import { Component, OnInit } from '@angular/core';
import { LINK_PAGE_PROFILE } from '../shared/consts';

@Component({
  selector: 'app-not-found',
  templateUrl: './not-found.component.html',
  styleUrls: ['./not-found.component.scss'],
})
export class NotFoundComponent implements OnInit {
  constructor() {}
  title = 'Страница не найдена';
  btn = { icon: 'home', title: 'Перейти в профиль', link: LINK_PAGE_PROFILE };
  ngOnInit() {}
}
