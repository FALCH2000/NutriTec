import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';


@Component({
  selector: 'app-pagina',
  templateUrl: './pagina.component.html',
  styleUrls: ['./pagina.component.css']
})
export class PaginaComponent implements OnInit {
  listProductos: any[] = [];
  displayedColumns: string[] = ['tipo_cobro', 'codigo_nutricionista', 'email',  'nombre',
                               'numero_tarjeta', 'cantidad_pacientes', 
                               'monto_total', 'descuento', 'monto_cobro'];
  dataSource!: MatTableDataSource<any>;

  constructor() { }

  ngOnInit(): void {
  }
  
  cargarCobro(){

  }

}
