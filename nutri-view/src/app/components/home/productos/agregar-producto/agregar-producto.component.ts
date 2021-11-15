import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
import { ProductosService } from 'src/app/services/productos.service';

@Component({
  selector: 'app-agregar-producto',
  templateUrl: './agregar-producto.component.html',
  styleUrls: ['./agregar-producto.component.css']
})

/**
 * Clase para el componente de Crear Empleado
 * @author Carmen Araya
 * */
export class AgregarProductoComponent implements OnInit {

  form: FormGroup;
  titulo = "Agregar Producto";

    /**
   * Metodo que constructor de la clase
   * @param FormBuilder formulario para crear un elemento
   * @param   ProductosService Servicio de Productos
   * @param router
   * @param ActivatedRoute
   * */
  constructor(
    private fb: FormBuilder,
    private _productosService: ProductosService,
    private router: Router,
    private aRoute: ActivatedRoute) {
    this.form = this.fb.group({
      codigo_de_barras: ['', Validators.required],
      descripcion: ['', Validators.required],
      tamano_porcion: ['', Validators.required],
      energia: ['', Validators.required],
      grasa: ['', Validators.required],
      sodio: ['', Validators.required],
      carbohidrato: ['', Validators.required],
      proteina: ['', Validators.required],
      calcio: ['', Validators.required],
      hierro: ['', Validators.required]
    })
  }

  /**
  * Metodo que ejecuta otros metodos al correr la aplicación
  * */
  ngOnInit(): void {
  }

    /**
  * Metodo que agrega un Producto nuevo a la base de datos
  * */
  agregarProducto(){
    if (this.form.invalid){
      return;
    }
    const producto: Object =
    {
      codigo_de_barras: this.form.value.codigo_de_barras,
      descripcion: this.form.value.descripcion,
      tamano_porcion: Number(this.form.value.tamano_porcion),
      energia: Number(this.form.value.energia),
      grasa: Number(this.form.value.grasa),
      sodio: Number(this.form.value.sodio),
      carbohidrato: Number(this.form.value.carbohidrato),
      proteina: Number(this.form.value.proteina),
      calcio:  Number(this.form.value.calcio),
      estado: "en espera",
      hierro:  Number(this.form.value.hierro),
    }
    console.log(producto)
    this._productosService.addProducto(producto)
  }

}
