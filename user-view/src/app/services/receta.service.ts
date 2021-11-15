import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json'
  })
};
@Injectable({
  providedIn: 'root'
})
export class RecetaService {

  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "https://nutritecapi.azurewebsites.net/"
  }


  addReceta(receta:Object){
    let params= JSON.stringify(receta);
    let header= new HttpHeaders().set('Content-Type','application/json');
    this._http.post(this.url+'api/Receta/NuevaReceta/insert', params, {headers:header}).subscribe(data => {
        console.log(data);
      });
  }
}