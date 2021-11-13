import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class NutriService {

  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "https://nutritecapi.azurewebsites.net/"
  }

  getNutricionistaByEmail(email:string): Observable<any> {
    return this._http.get(this.url + 'api/usuario/nutriXemail/'+email);
  }
  setNutricionistaValues(codigo:Object){
    
  }
  validarPassword(email:string, password:string){
    return this._http.get(this.url+ "api/usuario/validarusuario/"+ email+"/"+password+"/Nutricionista");
  }

}