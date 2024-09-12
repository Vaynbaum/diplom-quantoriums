export class ResponseItemModel<Type> {
  constructor(
    public items: Type[],
    public count: number,
    public num_offset?: number
  ) {}
}
