import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css']
})
export class InicioComponent implements OnInit {
  public nutriInfo:NutriInfo={
    nombre: '',
    codigo: '',
    cedula: 0,
    direccion:''
  }
  constructor(
    private _nutriService: UserService
  ) { }

  ngOnInit(): void {
    this.setValues();
  }
  setValues(){
    this.nutriInfo.nombre= this._nutriService.nutricionista.nombre1+" "+
      this._nutriService.nutricionista.nombre2+" "+ this._nutriService.nutricionista.apellido1
      +" "+this._nutriService.nutricionista.apellido2;
    this.nutriInfo.codigo= this._nutriService.nutricionista.codigo_nutricionista;
    this.nutriInfo.cedula= this._nutriService.nutricionista.cedula;
    this.nutriInfo.direccion= this._nutriService.nutricionista.direccion;
  }

}

export interface NutriInfo{
  nombre: string,
  codigo: string,
  cedula: number,
  direccion:string
}
