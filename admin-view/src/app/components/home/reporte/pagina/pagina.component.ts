import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { CobroService } from 'src/app/services/cobro.service';


@Component({
  selector: 'app-pagina',
  templateUrl: './pagina.component.html',
  styleUrls: ['./pagina.component.css']
})
export class PaginaComponent implements OnInit {
  listCobros: any[] = [];
  displayedColumns: string[] = ['tipo_cobro', 'codigo_nutricionista', 'email',  'nombre',
                               'numero_tarjeta', 'cantidad_pacientes', 
                               'monto_total', 'descuento', 'monto_cobro'];
  dataSource!: MatTableDataSource<any>;

  constructor(
    private _cobroService: CobroService
  ) { }

  ngOnInit(): void {
    this.cargarCobro();
  }

  cargarCobro(){
    this.listCobros=[];
    this._cobroService.getCobros().subscribe(
      result=> {
        var counter=0;
        while(result[counter]!=undefined){
          this.insertCobro(result[counter]);
          counter++;
        }
        this.dataSource = new MatTableDataSource(this.listCobros);
        
      }
    )
  }

  insertCobro(cobro:any){
    var cobroNuevo:Cobros= {
      tipo_cobro: cobro.tipo_cobro,
      codigo_nutricionista: cobro.codigo_nutricionista,
      email: cobro.email,
      nombre: cobro.nombre1+" " + cobro.nombre2+" "+cobro.apellido1+" "+cobro.apellido2,
      numero_tarjeta: cobro.numero_tarjeta,
      cantidad_pacientes: cobro.cantidad_pacientes,
      monto_total: cobro.monto_total,
      descuento: cobro.descuento,
      monto_cobro: cobro.monto_cobro
    }
    this.listCobros.push(cobroNuevo);
  }

}

export interface Cobros{
  tipo_cobro: string,
  codigo_nutricionista: string,
  email: string,
  nombre: string,
  numero_tarjeta: number,
  cantidad_pacientes: number,
  monto_total: number,
  descuento: number,
  monto_cobro: number
}
