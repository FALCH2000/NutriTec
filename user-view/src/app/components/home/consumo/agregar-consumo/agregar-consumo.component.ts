import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
import { ProductosService } from 'src/app/services/productos.service';
import { MatTableDataSource } from '@angular/material/table';
@Component({
  selector: 'app-agregar-consumo',
  templateUrl: './agregar-consumo.component.html',
  styleUrls: ['./agregar-consumo.component.css']
})
export class AgregarConsumoComponent implements OnInit {

  form: FormGroup;
  titulo = "Registrar Comsumo Diario";
  public productos: any;
  listProductos: any[] = [];
  listAprobados: any[] = [];
  displayedColumns: string[] = ['codigo_de_barras', 'descripcion', 'acciones'];
  dataSource!: MatTableDataSource<any>;


  constructor(
    private fb: FormBuilder,
    private _usuarioService: UsuarioService,
    private _productosService: ProductosService,
    private router: Router,
    private aRoute: ActivatedRoute) {
    this.form = this.fb.group({
      fecha: ['', Validators.required],
      almuerzo: ['', Validators.required],
      cena: ['', Validators.required],
      desayuno: ['', Validators.required],
      merienda_m: ['', Validators.required],
      merienda_t: ['', Validators.required],
      consumo_calorias: ['', Validators.required]
    })
  }

  ngOnInit(): void {
    this.cargarProductos()
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
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
        this.separarProductos()
      },
      error => {
        console.log("Error al cargar la lista de Empleados")
      });
  }

  separarProductos(){
    for( var i = 0; i < this.listProductos.length ; i++){
      if(this.listProductos[i].estado == 'aprobado'){
        this.listAprobados.push(this.listProductos[i])
      }
    }
    this.dataSource = new MatTableDataSource(this.listAprobados)
  }

  verProducto(codigo_de_barras: string){
    console.log(codigo_de_barras)
    this._productosService.getProductosByCodigo(codigo_de_barras).subscribe(data => {
      console.log(data);
    });
  }

  agregarConsumo(){
    if (this.form.invalid){
      return;
    }
    const consumo: Object =
    {
      fecha: "11/9/2021",
      almuerzo: this.form.value.almuerzo,
      cena: this.form.value.cena,
      desayuno: this.form.value.desayuno,
      merienda_manana: this.form.value.merienda_m,
      merienda_tarde: this.form.value.merienda_t,
      consumo_calorias: Number(this.form.value.consumo_calorias),
      cedula_paciente: 102222345
    }
    console.log(consumo)
    this._usuarioService.addConsumo(consumo)
  }

  consumo(codigo_de_barras: string){
    console.log(codigo_de_barras)
  }

}
