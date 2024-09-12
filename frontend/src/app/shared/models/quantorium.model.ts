import { RepresentativeWithUserModel } from './user.model';

export class QuantoriumModel {
  constructor(
    public id: number,
    public address: string,
    public created_at: Date | string,
    public img: object | null
  ) {}
}

export class QuantoriumWithRepresentativesModel {
  constructor(
    public id: number,
    public address: string,
    public created_at: Date | string,
    public img: object | null,
    public representatives: RepresentativeWithUserModel[]
  ) {}
}

export class QuantumModel {
  constructor(
    public id: number,
    public name: string,
    public img: object | null,
    public created_at: Date | string,
    public quantorium_id: number
  ) {}
}
export class QuantumQuantoriumModel {
  constructor(
    public id: number,
    public name: string,
    public img: object | null,
    public created_at: Date | string,
    public quantorium_id: number,
    public quantorium: QuantoriumModel
  ) {}
}
