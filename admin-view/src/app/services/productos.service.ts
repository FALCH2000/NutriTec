import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class ProductosService {

  public url: string;

  constructor(public _http: HttpClient
    ){
      this.url = "http://nutritecapi.azurewebsites.net/"
  }


  getProductos(): Observable<any> {
    return this._http.get(this.url + 'api/producto');
  }

}
