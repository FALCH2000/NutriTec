import { Component, OnInit, ViewChild } from '@angular/core';
import { ProductosService } from 'src/app/services/productos.service';
import { MatTableDataSource } from '@angular/material/table';

@Component({
  selector: 'app-productos',
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.css']
})

/**
 * Clase para el componente de Productos
 * @author Carmen Araya
 * */
export class ProductosComponent implements OnInit {

  titulo = 'Gestión de Productos'
  public productos: any;
  listProductos: any[] = [];
  displayedColumns: string[] = ['codigo_de_barras', 'descripcion', 'tamano_porcion', 'calcio', 'carbohidrato',
                               'energia', 'grasa', 'hierro', 'proteina', 'sodio'];
  dataSource!: MatTableDataSource<any>;

    /**
   * Metodo que constructor de la clase
   * @param _productosService Servicio de Productos
   * */
  constructor(
    private _productosService: ProductosService
  ) { }


  /**
  * Metodo que ejecuta otros metodos al correr la aplicación
  * */
  ngOnInit(): void {
    this.cargarProductos()
  }

  /**
   * Metodo para realizar la busqueda por nombre de los elementos de la tabla
  * */
  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  /**
  * Metodo que carga los productos que existen en la base de datos y los muestra en la tabla
  * */
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


}
