import { Component, Injector, OnInit } from '@angular/core';
import {
  DeletedReasonEvent,
  GetedReasonEvent,
  QuantoriumService,
} from '../../shared/services/quantorium.service';
import { ReasonModel } from '../../shared/models/reason.model';
import { MatDialog } from '@angular/material/dialog';
import { DialogAddReasonComponent } from '../dialog-add-reason/dialog-add-reason.component';

@Component({
  selector: 'app-dialog-reasons-more',
  templateUrl: './dialog-reasons-more.component.html',
  styleUrls: ['./dialog-reasons-more.component.scss'],
})
export class DialogReasonsMoreComponent implements OnInit {
  reasons: ReasonModel[] = [];
  constructor(
    private quantoriumService: QuantoriumService,
    public dialog: MatDialog,
    private injector: Injector
  ) {}

  ngOnInit() {
    DeletedReasonEvent.subscribe(() => this.quantoriumService.GetReasons());
    GetedReasonEvent.subscribe((reasons) => (this.reasons = reasons));
    this.quantoriumService.GetReasons();
  }
  deleteReason(reason: ReasonModel) {
    this.quantoriumService.DeleteReason(reason.id);
  }
  addReason() {
    let r = this.dialog.open(DialogAddReasonComponent, {
      maxWidth: '500px',
      injector: this.injector,
      width: '95vw',
      data: {
        quantorium_id: null,
      },
    });
    r.afterClosed().subscribe((res) => {
      if (res) this.quantoriumService.GetReasons();
    });
  }
}
