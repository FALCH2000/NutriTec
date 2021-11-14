import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {

  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "https://nutritecapi.azurewebsites.net/"
  }

  addMedida(dataMedida: Object){
    console.log(this.url+'api/paciente/medida/insert');
      this._http.post(this.url+'api/paciente/medida/insert', dataMedida).subscribe(data => {
      console.log(data);
    });
  }

  addConsumo(dataConsumo: Object){
    console.log(this.url+'api/paciente/consumo/insert');
      this._http.post(this.url+'api/Receta/registro/insert', dataConsumo).subscribe(data => {
      console.log(data);
    });
  }

}
