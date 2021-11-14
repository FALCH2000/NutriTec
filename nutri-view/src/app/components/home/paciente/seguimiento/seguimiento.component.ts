import { Component, OnInit } from '@angular/core';
import {PacienteService} from 'src/app/services/paciente.service'

interface pacientes{
  nombre:string,
  email:string,
  numero:number,
  cedula:number,
}

@Component({
  selector: 'app-seguimiento',
  templateUrl: './seguimiento.component.html',
  styleUrls: ['./seguimiento.component.css'],
  providers: [PacienteService]
})
export class SeguimientoComponent implements OnInit {
  public pacientesList=["Cristian","Raul","Alejandro", "Graciela", "Lila", "Rosa"];
  public displayUsuario= false;
  public pacienteSelected="";
  constructor(
    private _pacienteService: PacienteService
  ) { }

  ngOnInit(): void {

  }
  uploadPaciente(paciente:string){
    console.log("Seleccionamos a: "+ paciente);
    this.displayUsuario=true;
  }

}
