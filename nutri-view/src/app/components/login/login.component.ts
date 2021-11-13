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
  providers: [NutriService]
})
export class LoginComponent implements OnInit {

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
        console.log(result);
        this.validarPassword(nutriEmail, result);
      },
      error=> {
        console.log("ERROR OBTENIENDO USUARIO\n"+<any> error)
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
          this.router.navigate(['/home']);
        }else {
          alert("contra incorrecta compa");
        }
      },
      error=> {
        console.log("ERROR CONTRA\n"+<any> error)
      }
    )
  }
  

}
