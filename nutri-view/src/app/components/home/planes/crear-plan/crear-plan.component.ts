import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
import { ProductosService } from 'src/app/services/productos.service';
import { MatTableDataSource } from '@angular/material/table';

@Component({
  selector: 'app-crear-plan',
  templateUrl: './crear-plan.component.html',
  styleUrls: ['./crear-plan.component.css']
})

/**
 * Clase para el componente de Crear Planes
 * @author Carmen Araya
 * */
export class CrearPlanComponent implements OnInit {


  form: FormGroup;
  titulo = "Crear Plan Nutricional";
  public productos: any;
  listProductos: any[] = [];
  listAprobados: any[] = [];
  displayedColumns: string[] = ['codigo_de_barras', 'descripcion', 'acciones'];
  dataSource!: MatTableDataSource<any>;
  desayunoObjeto = {id_nutricionista:"N0002", producto:"", horario:"desayuno" };
  merienda1Objeto = {id_nutricionista:"N0002", producto:"", horario:"merienda_manana" };
  almuerzoObjeto = {id_nutricionista:"N0002", producto:"", horario:"almuerzo" };
  merienda2Objeto = {id_nutricionista:"N0002", producto:"", horario:"merienda_tarde" };
  cenaObjeto = {id_nutricionista:"N0002", producto:"", horario:"cena" };
  nombrePlan = ""

  /**
   * Metodo que constructor de la clase
   * @param FormBuilder formulario para crear un elemento
   * @param PlanesService Servicio de Planes
   * @param router
   * @param ActivatedRoute
   * */
  constructor(
    private fb: FormBuilder,
    private _productosService: ProductosService,
    private router: Router,
    private aRoute: ActivatedRoute) {
    this.form = this.fb.group({
      nombre: ['', Validators.required],
      almuerzo: ['', Validators.required],
      cena: ['', Validators.required],
      desayuno: ['', Validators.required],
      merienda_m: ['', Validators.required],
      merienda_t: ['', Validators.required]
    })
  }

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
        this.separarProductos()
      },
      error => {
        console.log("Error al cargar la lista de Empleados")
      });
  }


  /**
  * Metodo que separa los productos según su estado (aprobado y en espera)
  * */
  separarProductos(){
    for( var i = 0; i < this.listProductos.length ; i++){
      if(this.listProductos[i].estado == 'aprobado'){
        this.listAprobados.push(this.listProductos[i])
      }
    }
    this.dataSource = new MatTableDataSource(this.listAprobados)
  }

  /**
  * Metodo que completa el objeto desayuno para la creación de un plan
  * @param codigo de barras: string
  * @param nombre: String
  * */
  desayuno(codigo_de_barras: string, nombre: string){
    this.desayunoObjeto.producto = this.desayunoObjeto.producto + " " + nombre;
    this.form.setValue({
      nombre: this.nombrePlan,
      desayuno: this.desayunoObjeto.producto,
      almuerzo: this.almuerzoObjeto.producto,
      cena: this.cenaObjeto.producto,
      merienda_m: this.merienda1Objeto.producto,
      merienda_t: this.merienda2Objeto.producto,
  })
}

  /**
  * Metodo que completa el objeto merienda_manana para la creación de un plan
  * @param codigo de barras: string
  * @param nombre: String
  * */
  merienda1(codigo_de_barras: string, nombre: string){
    this.merienda1Objeto.producto = this.merienda1Objeto.producto + " " + nombre;
    this.form.setValue({
      nombre: this.nombrePlan,
      desayuno: this.desayunoObjeto.producto,
      almuerzo: this.almuerzoObjeto.producto,
      cena: this.cenaObjeto.producto,
      merienda_m: this.merienda1Objeto.producto,
      merienda_t: this.merienda2Objeto.producto,
  })
  }

    /**
  * Metodo que completa el objeto almuerzo para la creación de un plan
  * @param codigo de barras: string
  * @param nombre: String
  * */
  almuerzo(codigo_de_barras: string, nombre: string){
    this.almuerzoObjeto.producto = this.almuerzoObjeto.producto + " " + nombre;
    this.form.setValue({
      nombre: this.nombrePlan,
      desayuno: this.desayunoObjeto.producto,
      almuerzo: this.almuerzoObjeto.producto,
      cena: this.cenaObjeto.producto,
      merienda_m: this.merienda1Objeto.producto,
      merienda_t: this.merienda2Objeto.producto,
  })
  }

  /**
  * Metodo que completa el objeto merienda_tarde para la creación de un plan
  * @param codigo de barras: string
  * @param nombre: String
  * */
  merienda2(codigo_de_barras: string, nombre: string){
    this.merienda2Objeto.producto = this.merienda2Objeto.producto + " " + nombre;
    this.form.setValue({
      nombre: this.nombrePlan,
      desayuno: this.desayunoObjeto.producto,
      almuerzo: this.almuerzoObjeto.producto,
      cena: this.cenaObjeto.producto,
      merienda_m: this.merienda1Objeto.producto,
      merienda_t: this.merienda2Objeto.producto,
  })
  }

  /**
  * Metodo que completa el objeto cena para la creación de un plan
  * @param codigo de barras: string
  * @param nombre: String
  * */
  cena(codigo_de_barras: string, nombre: string){
    this.cenaObjeto.producto = this.cenaObjeto.producto + " " + nombre;
    this.form.setValue({
      nombre: this.nombrePlan,
      desayuno: this.desayunoObjeto.producto,
      almuerzo: this.almuerzoObjeto.producto,
      cena: this.cenaObjeto.producto,
      merienda_m: this.merienda1Objeto.producto,
      merienda_t: this.merienda2Objeto.producto,
  })
  }

  /**
  * Metodo que completa el nuevo plan a la base de datos
  * */
  agregarPlan(){
    this.nombrePlan = this.form.value.nombre;
    console.log(this.nombrePlan)
    console.log(this.desayunoObjeto)
  }

}
