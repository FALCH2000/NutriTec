import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
/**
 * Contiene las peticiones para pedir la informacion de pacientes
 */
export class ForoService {

  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "https://foromongoapi.azurewebsites.net/"
  }

    getMensajesTotales(): Observable<any>{
      return this._http.get(this.url+'api/foro');
    }
    getForo(cedula:string, codigo:string, foroId:string): Observable<any>{
        return this._http.get(this.url+'api/foro/getby/'+ cedula+'/'+codigo+'/'+foroId);
    }
    deleteMensaje(id: string | null){
        this._http.delete(this.url+'api/foro/delete/'+id).subscribe(data => {
            console.log(data);
            }); 
    }
    addMensaje(mensaje:any){
        this._http.post(this.url+ 'api/foro/insert', mensaje).subscribe(
            data=> { console.log(data)}
        )
    }

}