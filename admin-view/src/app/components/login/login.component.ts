import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/usuario.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [UserService]
})

export class LoginComponent implements OnInit {

  public notValidUser=false;
  public notValidPassword=false;

  constructor(
    private router:Router,
    private _userService: UserService
  ) { }

  ngOnInit(): void {
  }

  getUser(){
    var userEmail=(<HTMLInputElement>document.getElementById('username')).value;
    console.log('username es: '+userEmail);
    this._userService.getUserByEmail(userEmail).subscribe(
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
  validarPassword(nutriEmail:string, userInfo: Object){
    var nutriPassword=(<HTMLInputElement>document.getElementById('password')).value;

    this._userService.validarPassword(nutriEmail,nutriPassword).subscribe(
      result=> {
        console.log("resultado "+result);
        if(result==true){
          console.log("SUCCES");
          this._userService.setUserValues(userInfo);
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
