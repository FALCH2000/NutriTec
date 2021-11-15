import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';

interface Usuario{
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
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  public notValidUser=false;
  public notValidPassword=false;
  constructor(
    private router:Router,
    private _userService: UsuarioService,
  ) { }

  ngOnInit(): void {

  }
  getUser(){
    var userEmail=(<HTMLInputElement>document.getElementById('username')).value;
    console.log('username es: '+userEmail); 
    this._userService.getNutricionistaByEmail(userEmail).subscribe(
      result=> {
        if(result.nombre1==null){
          this.notValidUser=true;
        }else{
          this.validarPassword(userEmail, result);
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
  validarPassword(nutriEmail:string, nutriInfo: any){
    var userPassword=(<HTMLInputElement>document.getElementById('password')).value;

    this._userService.validarPassword(nutriEmail,userPassword).subscribe(
      result=> {
        console.log("resultado "+result);
        if(result==true){
          console.log("SUCCES");
          this._userService.setUserValues(nutriInfo);
          this.notValidPassword=false;
          this.router.navigate(['/home/inicio']);
        }else {
          this.notValidPassword=true;
        }
      },
      error=> {
        console.log("ERROR CONTRA\n"+<any> error)
        this.notValidPassword=true;
      }
    )
  }

}
