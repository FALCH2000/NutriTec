import { Component, OnInit } from '@angular/core';
import { PacienteService } from 'src/app/services/paciente.service';
import { NutriService} from 'src/app/services/usuario.service';

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
  providers: [PacienteService, NutriService]
})
export class AsociacionComponent implements OnInit {

  public lista: pacientesNoAsignados[]=[];
  constructor(
    private _pacienteService:PacienteService,
    private _nutriService: NutriService
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
    email:'',
    pais:"",
    cedula: 117711111}
    pacientesNoAsignados.cedula=paciente.cedula;
    pacientesNoAsignados.nombre1=paciente.nombre1;
    pacientesNoAsignados.email= paciente.email;
    pacientesNoAsignados.pais= paciente.pais;

    this.lista.push(pacientesNoAsignados);
  }

  asociar(cedula:number){
    console.log("este men más raro "+ cedula);
    this.obtenerPacienteInfo(cedula);
  }

  obtenerPacienteInfo(cedula:number){
    this._pacienteService.getPacienteByCedula(cedula).subscribe(
      result => {
        this.updatePacienteAsociar(result, cedula);
      },
      error => {
        console.log("ERROR CON OBTENER PACIENTE \n"+ <any>error);
      }
    )
  }

  updatePacienteAsociar(infoUser:Object, cedula:number){
    this._pacienteService.asignarNutricionista(infoUser, cedula,
      this._nutriService.nutricionista.codigo_nutricionista);
  }

}
