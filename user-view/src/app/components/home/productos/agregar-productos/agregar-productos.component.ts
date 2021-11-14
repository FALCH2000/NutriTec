import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
import { ProductosService } from 'src/app/services/productos.service';

@Component({
  selector: 'app-agregar-productos',
  templateUrl: './agregar-productos.component.html',
  styleUrls: ['./agregar-productos.component.css']
})
export class AgregarProductosComponent implements OnInit {

  form: FormGroup;
  titulo = "Agregar Producto";

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

  ngOnInit(): void {
  }

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
