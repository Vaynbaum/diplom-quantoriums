export class NewsModel {
  constructor(
    public id: number,
    public title: string,
    public created_at: Date | string,
    public description: string,
    public img: object | null,
    public representative_id: number,
    public quantorium_id: number
  ) {}
}
