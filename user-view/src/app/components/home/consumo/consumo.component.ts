import { Component, OnInit } from '@angular/core';
import {MatDialog, MatDialogConfig} from '@angular/material/dialog';
import { AgregarConsumoComponent } from './agregar-consumo/agregar-consumo.component';

@Component({
  selector: 'app-consumo',
  templateUrl: './consumo.component.html',
  styleUrls: ['./consumo.component.css']
})
export class ConsumoComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

}
