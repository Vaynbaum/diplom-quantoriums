import { Component, OnInit } from '@angular/core';
import { UserService } from '../shared/services/user.service';
import { EMAIL_SUPPORT } from '../shared/consts';

@Component({
  selector: 'app-system',
  templateUrl: './system.component.html',
  styleUrls: ['./system.component.scss'],
})
export class SystemComponent implements OnInit {
  constructor(private userService: UserService) {}
  titleSupport = 'Техническая поддержка ЛК';
  emailSupport = EMAIL_SUPPORT;
  ngOnInit() {
    this.userService.GetUserProfile();
  }
}
