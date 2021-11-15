import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

interface Usuario{
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
  peso:number,
  estado:string,
  imc:number,
  pais:string

}

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  
  public url: string;
  public usuario:Usuario={
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
    peso:0,
    estado:'',
    imc:0,
    pais:''

  }

  constructor(public _http: HttpClient
    ){
      this.url = "https://nutritecapi.azurewebsites.net/"
  }

  addMedida(dataMedida: Object){
    console.log(this.url+'api/paciente/medida/insert');
      this._http.post(this.url+'api/paciente/medida/insert', dataMedida).subscribe(data => {
      console.log(data);
    });
  }

  addConsumo(dataConsumo: Object){
    console.log(this.url+'api/paciente/consumo/insert');
      this._http.post(this.url+'api/Receta/registro/insert', dataConsumo).subscribe(data => {
      console.log(data);
    });
  }

  getNutricionistaByEmail(email:string): Observable<any> {
    return this._http.get(this.url + 'api/paciente/email/'+email);
  }

  /**
   * Setea los valores dentro del servicio para utilizarlo durante toda la ejecucion
   * @param nutricionista el objeto con la información del nutricionista 
   */
  setUserValues(usuarioObject:any){
    this.usuario.nombre1= usuarioObject.nombre1;
    this.usuario.nombre2= usuarioObject.nombre2;
    this.usuario.apellido1= usuarioObject.apellido1;
    this.usuario.apellido2= usuarioObject.apellido2;
    this.usuario.cedula=usuarioObject.cedula;
    this.usuario.codigo_nutricionista= usuarioObject.codigo_nutricionista;
    this.usuario.edad=usuarioObject.edad;
    this.usuario.email=usuarioObject.email;
    this.usuario.fecha_de_nacimiento= usuarioObject.fecha_de_nacimiento;
    this.usuario.pass= usuarioObject.pass;
    this.usuario.estado= usuarioObject.estado;
    this.usuario.imc= usuarioObject.imc;
    this.usuario.pais = usuarioObject.pais;
    this.usuario.peso = usuarioObject.peso;
  }

  /**
   * Valida la contrasenna ingresada
   * @param email el email del usuario
   * @param password la contrasenna que se ingresa
   * @returns el resultado true o false 
   */
  validarPassword(email:string, password:string){
    return this._http.get(this.url+ "api/paciente/validar/"+ email+"/"+password);
  }

}
