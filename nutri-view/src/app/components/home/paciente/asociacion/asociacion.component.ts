import { Component, OnInit } from '@angular/core';

interface pacientesNoAsignados{
  nombre:string,
  email:string,
  numero:number,
  cedula:number,
}

@Component({
  selector: 'app-asociacion',
  templateUrl: './asociacion.component.html',
  styleUrls: ['./asociacion.component.css']
})
export class AsociacionComponent implements OnInit {
  public pacientesNoAsignados:pacientesNoAsignados={
    nombre:'Wei',
    email:'wei@gmail.com',
    numero:88888888,
    cedula: 117711111
  }
  public lista=[this.pacientesNoAsignados];
  constructor() { }

  ngOnInit(): void {
  }

}
