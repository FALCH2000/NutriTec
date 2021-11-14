import { Component, OnInit } from '@angular/core';
import {PacienteService} from 'src/app/services/paciente.service'

interface Paciente{
  nombre:string,
  email:string,
  peso:number,
  cedula:number,
  estado:string,
  edad:number,
  pais:string
}

@Component({
  selector: 'app-seguimiento',
  templateUrl: './seguimiento.component.html',
  styleUrls: ['./seguimiento.component.css'],
  providers: [PacienteService]
})
export class SeguimientoComponent implements OnInit {
  public pacientesList:any=[];
  public registroList:any=[];
  public displayUsuario= false;
  public pacienteSelected="";
  public paciente:Paciente= {
    nombre:'',
    email:'',
    peso:0,
    cedula:0,
    estado:'',
    edad:0,
    pais:''
  }
  constructor(
    private _pacienteService: PacienteService
  ) { }

  ngOnInit(): void {
    this.getPacientesDeNutri();
  }
  uploadPaciente(paciente:any){
    console.log("Seleccionamos a: "+ paciente.nombre);
    this._pacienteService.getPacienteByCedula(paciente.cedula).subscribe(
      result=>{
        this.displayUsuario=true;
        this.setPacienteSelected(result);
      },
      error=>{
        console.log("Error cargando a un paciente "+ <any>error);
      }
    )
  }
  
  getPacientesDeNutri(){
    var codigo= "N0002"; //TENGO QUE USAR EL CODIGO DEL NUTRICIONISTA ACTUAL
    this._pacienteService.getPacientesByCodigo(codigo).subscribe(
      result => {
        var counter=0;
        while(result[counter]!=undefined){
          var auxiliar=result[counter];
          this.pacientesList.push({nombre:auxiliar.nombre1+" "+ auxiliar.nombre2, 
          cedula:auxiliar.cedula});
          counter++;
        }
      },
      error => {
        console.log("Error "+ <any>error);
      } 
    )
  }
  setPacienteSelected(infoPaciente:any){
    this.paciente.nombre= infoPaciente.nombre1+" "+infoPaciente.nombre2+" "+
    infoPaciente.apellido1+" "+infoPaciente.apellido2;
    this.paciente.cedula= infoPaciente.cedula;
    this.paciente.edad= infoPaciente.edad;
    this.paciente.email=infoPaciente.email;
    this.paciente.estado= infoPaciente.estado;
    this.paciente.pais= infoPaciente.pais;
    this.paciente.peso= infoPaciente.peso;

    this.setRegistro();
  }

  setRegistro(){
    this._pacienteService.getConsumoPaciente(this.paciente.cedula).subscribe(
      result => {
        var counter=0;
        this.registroList=[];
        while(result[counter]!=undefined){
          var auxiliar=result[counter];
          this.registroList.push(auxiliar);
          counter++;
        }
      },
      error => {
        console.log("Error con el registro weon "+ <any>error)
      }
    )
  }

}
