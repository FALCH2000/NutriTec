import {TemplateRef, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';



@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(
    private router:Router
  ) { }

  ngOnInit(): void {
  }

  getUser(){
    var texto=(<HTMLInputElement>document.getElementById('username')).value;
    console.log('username es: '+texto); 
    var textoPas=(<HTMLInputElement>document.getElementById('password')).value;
    console.log('password es: '+textoPas); 
    /** 
    this._clienteService.getUserbyId(texto).subscribe(
      result => {
        this.user= result;
        this._clienteService.infoUser=result;
        this._clienteService.setCurrentlyUser();
        this.validarContra();
        
      },
      error => {
        console.log("hubo algun error \n" + <any>error);
        alert("Error al ingresar el usuario \n Intentelo de nuevo");
      }
    ); */
  }
  /** Valida la contrasenna ingresada por el usuario */
  validarPassword(){
    var textoPas=(<HTMLInputElement>document.getElementById('password')).value;
    console.log('password es: '+textoPas); 
    /** 
    this._clienteService.getValidacionPas(textoPas).subscribe(
      result => {
        console.log(result);
        if(result==true){
          this.router.navigate(['Cartelera']);
        }else{
          alert("Error al ingresar su contraseña \n Intentelo de nuevo");
        }
        
      },
      error => {
        console.log("hubo algun error \n" + <any>error);
        alert("Error al ingresar el usuario \n Intentelo de nuevo");
      }
    ); */
  }
  

}
