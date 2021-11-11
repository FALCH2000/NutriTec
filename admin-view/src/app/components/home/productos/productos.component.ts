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
  listAprobados: any[] = [];
  listEspera: any[] = [];
  displayedColumns: string[] = ['codigo_de_barras', 'descripcion', 'tamano_porcion', 'acciones'];
  dataSource!: MatTableDataSource<any>;
  
  

  constructor(
    private _productosService: ProductosService
  ) { }

  ngOnInit(): void {
    this.cargarProductos()
  }

  separarProductos(){
    for( var i = 0; i < this.listProductos.length ; i++){
      if(this.listProductos[i].estado == 'aprobado'){
        this.listAprobados.push(this.listProductos[i])
      }else{
        this.listEspera.push(this.listProductos[i])
      }
    }
    console.log(this.listAprobados)
    console.log(this.listEspera)
  }

  actualizarTabla(actualizar: String){
    if (actualizar == 'aprobados'){
      this.titulo = 'Productos Aprobados'
      this.dataSource = new MatTableDataSource(this.listAprobados)
    }else if( actualizar == 'espera'){
      this.titulo = 'Productos en Espera'
      this.dataSource = new MatTableDataSource(this.listEspera)
    }else{
      this.titulo = 'Gestión de Productos'
      this.dataSource = new MatTableDataSource(this.listProductos)
    }
  }

  actualizarProducto(codigo: string, estado: string){
    console.log(codigo + "  " + estado)
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
        this.separarProductos();
      },
      error => {
        console.log("Error al cargar la lista de Empleados")
      });
  }

}
