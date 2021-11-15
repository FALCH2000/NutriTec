import { Component, OnInit } from '@angular/core';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css']
})
export class InicioComponent implements OnInit {
  public nutriInfo:UsuarioInfo={
    nombre: '',
    estado: '',
    cedula: 0,
    peso:0,
    imc:0,
    pais:''
  }

  constructor(
    private _usuarioService: UsuarioService
  ) { }

  ngOnInit(): void {
    this.setValues();
  }
  setValues(){
    this.nutriInfo.nombre= this._usuarioService.usuario.nombre1+" "+
      this._usuarioService.usuario.nombre2+" "+ this._usuarioService.usuario.apellido1
      +" "+this._usuarioService.usuario.apellido2;
    this.nutriInfo.estado= this._usuarioService.usuario.estado;
    this.nutriInfo.cedula= this._usuarioService.usuario.cedula;

    this.nutriInfo.peso= this._usuarioService.usuario.peso;
    this.nutriInfo.imc=this._usuarioService.usuario.imc;
    this.nutriInfo.pais= this._usuarioService.usuario.pais;
  }

}

export interface UsuarioInfo{
  nombre: string,
  estado: string,
  cedula:number,
  peso:number,
  imc:number,
  pais:string
}
