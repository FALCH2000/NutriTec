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


  updateEmpleado(dataProducto: Object, codigo: string, estado: string): Observable<any>{
    return this._http.put(this.url+'api/producto/aprovacion/'+codigo+'/'+estado, dataProducto);
  }

  getProductos(): Observable<any> {
    console.log(this.url + 'api/producto')
    return this._http.get(this.url + 'api/producto');
  }

}
