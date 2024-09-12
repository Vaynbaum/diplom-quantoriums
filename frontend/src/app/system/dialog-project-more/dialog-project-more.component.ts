import {
  DeletedProjectLinkEvent,
  QuantoriumService,
} from './../../shared/services/quantorium.service';
import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {
  FullProjectModel,
  ProjectLinkUserModel,
  ProjectModel,
} from '../../shared/models/project.model';
import { ImageService } from '../../shared/services/image.service';
import { FILE_ICONS, LINK_PAGE_PROFILE_SHORT } from '../../shared/consts';
import {
  FullUserModel,
  StudentUserModel,
} from '../../shared/models/user.model';
import { Router } from '@angular/router';
export type DialogMoreProjectData = {
  project: ProjectModel;
  profile: FullUserModel;
};
@Component({
  selector: 'app-dialog-project-more',
  templateUrl: './dialog-project-more.component.html',
  styleUrls: ['./dialog-project-more.component.scss'],
})
export class DialogProjectMoreComponent implements OnInit {
  project: FullProjectModel | null = null;
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogMoreProjectData,
    private quantoriumService: QuantoriumService,
    private imageService: ImageService,
    private router: Router,
    public dialogRef: MatDialogRef<DialogProjectMoreComponent>
  ) {}

  ngOnInit() {
    this.quantoriumService
      .GetProject(this.data.project.id)
      .subscribe((project) => (this.project = project));

    DeletedProjectLinkEvent.subscribe(() => {
      this.quantoriumService
        .GetProject(this.data.project.id)
        .subscribe((project) => (this.project = project));
    });
  }

  compileUrl(img: object | null | undefined) {
    return this.imageService.getImg(img, '/assets/images/no-photo.png');
  }
  getImage(img: any) {
    let abr = img.name.split('.').at(-1);
    let r = FILE_ICONS.get(abr);
    let url = 'other-icon.png';
    if (r) url = r;
    return `/assets/images/${url}`;
  }
  redirectLink(url: string) {
    let c_url = this.imageService.getImg(url);
    if (c_url) window.open(c_url, '_blank');
  }
  getFullname(p: StudentUserModel) {
    return `${p.user.lastname} ${p.user.firstname} ${p.patronymic}`;
  }
  goToUser(user: StudentUserModel) {
    this.router.navigate([`${LINK_PAGE_PROFILE_SHORT}/${user.user_id}`]);
    this.dialogRef.close();
  }

  canDelete() {
    return this.data.profile.id == this.data.project.student_id;
  }

  deleteLink(link: ProjectLinkUserModel) {
    this.quantoriumService.DeleteProjectLink({
      project_id: link.project_id,
      student_id: link.student_id,
    });
  }
}
