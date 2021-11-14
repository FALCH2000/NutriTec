import { Component, OnInit } from '@angular/core';
import { PacienteService } from 'src/app/services/paciente.service';

interface pacientesNoAsignados{
  nombre1:string,
  email:string,
  pais:string,
  cedula:number,
}

@Component({
  selector: 'app-asociacion',
  templateUrl: './asociacion.component.html',
  styleUrls: ['./asociacion.component.css'],
  providers: [PacienteService]
})
export class AsociacionComponent implements OnInit {
  public pacientesNoAsignados1:pacientesNoAsignados={
    nombre1:'Wei',
    email:'wei@gmail.com',
    pais:"CR",
    cedula: 117711111
  }

  public lista: pacientesNoAsignados[]=[this.pacientesNoAsignados1];
  constructor(
    private _pacienteService:PacienteService
  ) { }

  ngOnInit(): void {
    this.getPacientesNoAsignados();
  }
  getPacientesNoAsignados(){
    
    this._pacienteService.getPacientesDesocupados().subscribe(
      result => {
        var counter=0;
        while(result[counter]!=undefined){
          var auxiliar=result[counter];
          this.cargarPaciente(auxiliar);
          counter++;
        }
      },
      error=> {
        console.log("Error"+ <any>error)
      }
    )
  }

  cargarPaciente(paciente:any){
    var pacientesNoAsignados:pacientesNoAsignados={nombre1:'Wei',
    email:'wei@gmail.com',
    pais:"CR",
    cedula: 117711111}
    pacientesNoAsignados.cedula=paciente.cedula;
    pacientesNoAsignados.nombre1=paciente.nombre1;
    pacientesNoAsignados.email= paciente.email;
    pacientesNoAsignados.pais= paciente.pais;

    this.lista.push(pacientesNoAsignados);
  }

  asociar(cedula:number){
    console.log("este men más raro "+ cedula);
  }

}
