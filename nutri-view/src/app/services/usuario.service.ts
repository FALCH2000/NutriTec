import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
/**
 * Contiene los servicios y peticiones respectivas al nutricionista que ingresa
 */
export class NutriService {

  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "https://nutritecapi.azurewebsites.net/"
  }
  /**
   * Obtiene la informacion de un nutricionista asociado al email
   * @param email es el email del nutricionista que hace login
   * @returns objeto con el resultado
   */
  getNutricionistaByEmail(email:string): Observable<any> {
    return this._http.get(this.url + 'api/usuario/nutriXemail/'+email);
  }

  /**
   * Setea los valores dentro del servicio para utilizarlo durante toda la ejecucion
   * @param nutricionista el objeto con la información del nutricionista 
   */
  setNutricionistaValues(nutricionista:Object){
    
  }
  /**
   * Valida la contrasenna ingresada
   * @param email el email del usuario
   * @param password la contrasenna que se ingresa
   * @returns el resultado true o false 
   */
  validarPassword(email:string, password:string){
    return this._http.get(this.url+ "api/usuario/validarusuario/"+ email+"/"+password+"/Nutricionista");
  }

}