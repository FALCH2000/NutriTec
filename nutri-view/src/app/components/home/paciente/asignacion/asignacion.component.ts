import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl} from '@angular/forms';

interface pacientes{
  nombre:string,
  email:string,
  numero:number,
  cedula:number,
}

@Component({
  selector: 'app-asignacion',
  templateUrl: './asignacion.component.html',
  styleUrls: ['./asignacion.component.css']
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
  public lista=[this.pacientesNoAsignados];
  constructor() {}

  ngOnInit(): void {
  }

}
