import { Component, OnInit, Inject } from '@angular/core';
import { PlanesService } from 'src/app/services/planes.service';
import { MatTableDataSource } from '@angular/material/table';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-planes',
  templateUrl: './planes.component.html',
  styleUrls: ['./planes.component.css'],
  providers: [PlanesService]
})
export class PlanesComponent implements OnInit {

  planesList: any[] = [];
  displayedColumns: string[] = ['nombre', 'nutricionista', 'acciones'];
  dataSource!: MatTableDataSource<any>;

  constructor(
    private _planesService: PlanesService,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    this.cargarPlanes();
  }

  cargarPlanes(){
    this._planesService.getPlanes().subscribe(
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



