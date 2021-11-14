import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl} from '@angular/forms';
import { PlanesService} from 'src/app/services/planes.service';

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
  public pacientesNoAsignados:pacientes={
    nombre:'Wei',
    email:'wei@gmail.com',
    numero:88888888,
    cedula: 117711111
  }
  public pacientesList=["Cristian","Raul","Alejandro"]
  public planesList:any= [];
  public lista=[this.pacientesNoAsignados];
  
  constructor(
    private _planesService:PlanesService
  ) {}

  ngOnInit(): void {
    this.getPlanes();
  }
  getPlanes(){
    this._planesService.getPlanes().subscribe(
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

}
