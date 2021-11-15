import { Component, OnInit, Inject } from '@angular/core';
import { PlanesService } from 'src/app/services/planes.service';
import { MatTableDataSource } from '@angular/material/table';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { NutriService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-planes',
  templateUrl: './planes.component.html',
  styleUrls: ['./planes.component.css'],
  providers: [PlanesService]
})

/**
 * Clase para el componente de Planes
 * @author Carmen Araya
 * */
export class PlanesComponent implements OnInit {

  planesList: any[] = [];
  displayedColumns: string[] = ['nombre', 'nutricionista','acciones'];
  dataSource!: MatTableDataSource<any>;


  /**
   * Metodo que constructor de la clase
   * @param _planesService Servicio de Planes
   * */
  constructor(
    private _planesService: PlanesService,
    public dialog: MatDialog,
    private _usuarioService: NutriService
  ) { }


  /**
  * Metodo que ejecuta otros metodos al correr la aplicación
  * */
  ngOnInit(): void {
    this.cargarPlanes();
  }

  /**
   * Metodo para realizar la busqueda por nombre de los elementos de la tabla
  * */
   applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  /**
  * Metodo que carga los planes que existen en la base de datos y los muestra en la tabla
  * */
  cargarPlanes(){
    this._planesService.getPlanes(this._usuarioService.nutricionista.codigo_nutricionista).subscribe(
      result => {
        result;
        var i = 0;
        while(result[i] != undefined){
          this.planesList.push({nombre:result[i].nombre, nutricionista: result[i].nutricionista});
          i++;
        }
        this.dataSource = new MatTableDataSource(this.planesList)
        //this.dataSource.paginator = this.paginator;
        console.log(this.planesList)
      },
      error => {
        console.log("Error al cargar la lista de Empleados")
      });
  }
}



