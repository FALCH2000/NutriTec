import { Component, OnInit } from '@angular/core';

interface pacientes{
  nombre:string,
  email:string,
  numero:number,
  cedula:number,
}

@Component({
  selector: 'app-seguimiento',
  templateUrl: './seguimiento.component.html',
  styleUrls: ['./seguimiento.component.css']
})
export class SeguimientoComponent implements OnInit {
  public pacientesList=["Cristian","Raul","Alejandro", "Graciela", "Lila", "Rosa"];
  constructor() { }

  ngOnInit(): void {
  }

}
