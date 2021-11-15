import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl} from '@angular/forms';
import { PlanesService} from 'src/app/services/planes.service';
import { NutriService} from 'src/app/services/usuario.service';
import { PacienteService} from 'src/app/services/paciente.service'

interface pacientes{
  nombre:string,
  email:string,
  numero:number,
  cedula:number,
}

@Component({
  selector: 'app-asignacion',
  templateUrl: './asignacion.component.html',
  styleUrls: ['./asignacion.component.css'],
  providers: [PlanesService]
})
export class AsignacionComponent implements OnInit {
  range = new FormGroup({
    start: new FormControl(),
    end: new FormControl(),
  });

  public pacientesList:any=[]
  public planesList:any= [];

  constructor(
    private _planesService:PlanesService,
    private _pacienteService:PacienteService,
    private _nutriService:NutriService
  ) {}

  ngOnInit(): void {
    this.getPlanes();
    this.getPacientesDeNutri();
  }
  getPlanes(){
    console.log(this._nutriService.nutricionista.codigo_nutricionista)
    this._planesService.getPlanes(this._nutriService.nutricionista.codigo_nutricionista).subscribe(
      result => {
        var counter=0;
        while(result[counter]!=undefined){
          var auxiliar=result[counter];
          this.planesList.push(auxiliar.nombre);

          counter++;
        }
      },
      error => {
        alert("Error obteniendo los planes");
        console.log("Error "+ <any>error);
      }
    )
  }

  getPacientesDeNutri(){
    console.log("Obtiene toda la caca");
    var codigo= this._nutriService.nutricionista.codigo_nutricionista;
    this._pacienteService.getPacientesByCodigo(codigo).subscribe(
      result => {
        var counter=0;
        while(result[counter]!=undefined){
          var auxiliar=result[counter];
          this.pacientesList.push(auxiliar.nombre1+" "+ auxiliar.nombre2);
          counter++;
        }
        console.log(this.pacientesList);
      },
      error => {
        console.log("Error "+ <any>error);
      }
    )
  }

}
