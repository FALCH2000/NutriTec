import { Component, OnInit, ViewChild } from '@angular/core';
import { ProductosService } from 'src/app/services/productos.service';
import { MatTableDataSource } from '@angular/material/table';

@Component({
  selector: 'app-productos',
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.css']
})
export class ProductosComponent implements OnInit {

  titulo = 'Gestión de Productos'
  public productos: any;
  listProductos: any[] = [];
  displayedColumns: string[] = ['codigo_de_barras', 'descripcion', 'tamano_porcion', 'acciones'];
  dataSource!: MatTableDataSource<any>;

  constructor(
    private _productosService: ProductosService
  ) { }

  ngOnInit(): void {
    this.cargarProductos()
  }

  cargarProductos(){
    this._productosService.getProductos().subscribe(
      result => {
        result;
        var i = 0;
        while(result[i] != undefined){
          this.listProductos.push({codigo_de_barras:result[i].codigo_de_barras,
                                  descripcion:result[i].descripcion, tamano_porcion: result[i].tamano_porcion,
                                  energia:result[i].energia, grasa:result[i].grasa, sodio:result[i].sodio,
                                  carbohidrato:result[i].carbohidrato, proteina:result[i].proteina,
                                  calcio:result[i].calcio, hierro:result[i].hierro,
                                  estado:result[i].estado});
          i++;
        }
        this.dataSource = new MatTableDataSource(this.listProductos)
        console.log(this.listProductos)
      },
      error => {
        console.log("Error al cargar la lista de Empleados")
      });
  }

  verProducto(codigo_de_barras: string){
    console.log(codigo_de_barras)
    this._productosService.getProductosByCodigo(codigo_de_barras).subscribe(data => {
      console.log(data);
    });
  }

}
