export class ReasonModel {
  constructor(
    public id: number,
    public date_begin: Date | string,
    public name: string,
    public date_end: Date | string,
    public quantorium_id: number
  ) {}
}
