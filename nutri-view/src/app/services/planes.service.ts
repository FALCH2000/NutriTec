import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PlanesService {
  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "https://nutritecapi.azurewebsites.net/"
  }

  getPlanes(codigo_nutricionista: string): Observable<any> {
    return this._http.get(this.url + 'api/planes/nut/'+codigo_nutricionista);
  }

  postPlanes(plan: Object){
    console.log(this.url+'api/producto/insert');
    this._http.post(this.url+'api/planes/insertplan', plan).subscribe(data => {
    console.log(data);
  });
  }

}
