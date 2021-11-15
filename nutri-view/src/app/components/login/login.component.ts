import {TemplateRef, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';
import { NutriService } from 'src/app/services/usuario.service';

interface Nutricionista{
  nombre1:string,
  nombre2:string,
  apellido1:string,
  apellido2:string,
  codigo:string,
  correo:string
}

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  
})
export class LoginComponent implements OnInit {
  public notValidUser=false;
  public notValidPassword=false;
  constructor(
    private router:Router,
    private _nutriService: NutriService,
  ) { }

  ngOnInit(): void {
  }

  getNutriUser(){
    var nutriEmail=(<HTMLInputElement>document.getElementById('username')).value;
    console.log('username es: '+nutriEmail);
    this._nutriService.getNutricionistaByEmail(nutriEmail).subscribe(
      result=> {
        console.log("no se poe que"+result);
        if(result.nombre1==null){
          this.notValidUser=true;
        }else{
          this.validarPassword(nutriEmail, result);
          this.notValidUser=false;
        }

      },
      error=> {
        console.log("ERROR OBTENIENDO USUARIO\n"+<any> error)
        this.notValidUser=true;
      }
    )
  }

  /** Valida la contrasenna ingresada por el usuario */
  validarPassword(nutriEmail:string, nutriInfo: Object){
    var nutriPassword=(<HTMLInputElement>document.getElementById('password')).value;

    this._nutriService.validarPassword(nutriEmail,nutriPassword).subscribe(
      result=> {
        console.log("resultado "+result);
        if(result==true){
          console.log("SUCCES");
          this._nutriService.setNutricionistaValues(nutriInfo);
          this.notValidPassword=false;
          this.router.navigate(['/home/inicio']);
        }else {
          this.notValidPassword=true;
        }
      },
      error=> {
        console.log("ERROR CONTRA\n"+<any> error)
      }
    )
  }
}
