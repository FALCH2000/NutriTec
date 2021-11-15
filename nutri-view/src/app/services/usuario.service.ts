import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

interface Nutricionista{
  nombre1:string,
  nombre2:string,
  apellido1:string,
  apellido2:string,
  cedula:number,
  fecha_de_nacimiento:string,
  edad:number,
  codigo_nutricionista:string,
  pass:string,
  email:string,
  numero_tarjeta:number,
  tipo_cobro:string,
  rol:string,
  direccion:string,
  foto:string
}

@Injectable({
  providedIn: 'root'
})
/**
 * Contiene los servicios y peticiones respectivas al nutricionista que ingresa
 */
export class NutriService {
  public url: string;
  public nutricionista:Nutricionista={
    nombre1:'',
    nombre2:'',
    apellido1:'',
    apellido2:'',
    cedula:0,
    fecha_de_nacimiento:'',
    edad:0,
    codigo_nutricionista:'',
    pass:'',
    email:'',
    numero_tarjeta:0,
    tipo_cobro:'',
    rol:'',
    direccion:'',
    foto:''
  }

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
  setNutricionistaValues(nutricionistaObject:any){
    this.nutricionista.nombre1= nutricionistaObject.nombre1;
    this.nutricionista.nombre2= nutricionistaObject.nombre2;
    this.nutricionista.apellido1= nutricionistaObject.apellido1;
    this.nutricionista.apellido2= nutricionistaObject.apellido2;
    this.nutricionista.cedula=nutricionistaObject.cedula;
    this.nutricionista.codigo_nutricionista= nutricionistaObject.codigo_nutricionista;
    this.nutricionista.edad=nutricionistaObject.edad;
    this.nutricionista.email=nutricionistaObject.email;
    this.nutricionista.fecha_de_nacimiento= nutricionistaObject.fecha_de_nacimiento;
    this.nutricionista.direccion= nutricionistaObject.direccion;
    this.nutricionista.foto= nutricionistaObject.foto;
    this.nutricionista.numero_tarjeta= nutricionistaObject.numero_tarjeta;
    this.nutricionista.pass= nutricionistaObject.pass;
    this.nutricionista.rol= nutricionistaObject.rol;
    this.nutricionista.tipo_cobro= nutricionistaObject.tipo_cobro;
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

  postNutricionista(nutriData: Object){
    this._http.post(this.url+'api/usuario/insert', nutriData).subscribe(data => {
    console.log(data);
  });
  }

}
