import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
/**
 * Contiene las peticiones para pedir la informacion de pacientes
 */
export class PacienteService {

  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "https://nutritecapi.azurewebsites.net/"
  }
  /**
   * Obtiene los pacientes sin nutricionista asignado
   * @returns lista con la informacion de pacientes
   */
  getPacientesDesocupados(): Observable<any> {
    return this._http.get(this.url + 'api/paciente/libres');
  }

  asignarNutricionista(infoPaciente:Object, cedula:number, codigo: string){
      var codigoPatito= 'N0002';
      this._http.put(this.url+'api/paciente/asignar/'+cedula+'/'+codigoPatito, infoPaciente).subscribe(
          data => {"Data del update "+console.log(data);
    });
  }

  desligarPaciente(cedula: string | null){
      this._http.delete(this.url+'api/paciente/desligarnutri/'+cedula).subscribe(data => {
      console.log(data);
    });
  }

  getPacienteByCedula(cedula:number): Observable<any>{
    return this._http.get(this.url+ 'api/paciente/get/'+cedula);
  }

  getPacientesByCodigo(codigoNutri:string): Observable<any>{
    return this._http.get(this.url + 'api/usuario/pacientes/'+ codigoNutri);
  }

  getConsumoPaciente(cedula:number): Observable<any>{
    return this._http.get(this.url+'api/paciente/consumo/'+cedula);
  }


}