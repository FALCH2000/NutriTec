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
      this.url = "https://nutritecapi.azurewebsites.net/"
  }


  updateProducto(dataProducto: Object, codigo: string, estado: string): Observable<any>{
    console.log(this.url+'api/producto/aprovacion/'+codigo+'/'+estado, dataProducto)
    return this._http.put(this.url+'api/producto/aprovacion/'+codigo+'/'+estado, dataProducto);
  }

  getProductos(): Observable<any> {
    console.log(this.url + 'api/producto')
    return this._http.get(this.url + 'api/producto');
  }

}
