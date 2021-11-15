import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import {MatTableDataSource} from '@angular/material/table';
import { ProductosService } from 'src/app/services/productos.service';
import { RecetaService } from 'src/app/services/receta.service';
import { UsuarioService } from 'src/app/services/usuario.service';


@Component({
  selector: 'app-recetas',
  templateUrl: './recetas.component.html',
  styleUrls: ['./recetas.component.css'],
  providers: [ ProductosService, RecetaService]
})
export class RecetasComponent implements OnInit, AfterViewInit {
  displayedColumns: string[] = ['position', 'name', 'weight', 'symbol'];
  dataSource3!: MatTableDataSource<any>;
  public listaProductos: Producto[]=[];
  public listaProductosSeleccionados: Producto[]=[];
  public nombreReceta!:any;
  public listaRecetaPorEnviar:any[]=[];
  
  

  @ViewChild(MatPaginator) paginator: MatPaginator;

  constructor(
    private _productoService:ProductosService,
    private _recetaService:RecetaService,
    private _usuarioService:UsuarioService
  ) { 
    var i:any;
    this.paginator=i;
    this.fullTable();
  }

  ngOnInit(): void {
    console.log("El usuario en receta es "+ this._usuarioService.usuario.nombre1);
  } 

  ngAfterViewInit(): void{
    this.dataSource3.paginator = this.paginator;
  }

  fullTable(){
    this._productoService.getProductosAprobados().subscribe(
      result=> {
        var counter=0;
        while(result[counter]!=undefined){
          this.newProducto(result[counter]);
          counter++;
        }
        this.dataSource3 = new MatTableDataSource(this.listaProductos);
        this.dataSource3.paginator = this.paginator;
      },
      error => {
        console.log("Error obteniendo productos\n"+<any>error);
      }
    )
  }

  newProducto(productoObj:any){
    var producto:Producto=  {
      codigo_de_barras: productoObj.codigo_de_barras,
      descripcion: productoObj.descripcion,
      tamano_porcion: productoObj.tamano_porcion,
      energia: productoObj.energia,
      grasa: productoObj.grasa,
      sodio: productoObj.sodio,
      carbohidrato: productoObj.carbohidrato,
      proteina: productoObj.proteina,
      calcio: productoObj.calcio,
      estado: productoObj.estado,
      hierro: productoObj.hierro
    }
    this.listaProductos.push(producto);
  }
  checkCheckBoxvalue(event:any, producto:any){
    this.updateListaSeleccion(event.checked, producto);
  }
  public updateListaSeleccion(estado:boolean, producto:any){
    console.log("Lista productos selectos");
    console.log(this.listaProductosSeleccionados);
    if(estado==true ){
      var index = this.listaProductosSeleccionados.indexOf(producto);
      if(!(index > -1)){
        this.listaProductosSeleccionados.push(producto);
      }
    }else{
      var index = this.listaProductosSeleccionados.indexOf(producto);

      if (index > -1) {
        this.listaProductosSeleccionados.splice(index, 1);
      }
    }
  }

  crearReceta(){

    this._recetaService.addReceta(this.listaRecetaPorEnviar);
    
  }
  
  fullListaReceta(){
    var counter=0;
    this.listaRecetaPorEnviar=[];
    while(this.listaProductosSeleccionados[counter]!=undefined){
      this.listaRecetaPorEnviar.push({
        "email": this._usuarioService.usuario.email, 
        "nombre": this.nombreReceta, 
        "tamano": 100, 
        "producto" : this.listaProductosSeleccionados[counter].descripcion
        }); 
        counter++;
    }
    
    this.crearReceta();
  }

}


export interface Producto {
  codigo_de_barras: string,
  descripcion:string,
  tamano_porcion:number,
  energia:number,
  grasa:number,
  sodio:number,
  carbohidrato:number,
  proteina:number,
  calcio:number,
  estado: string,
  hierro:number
}


