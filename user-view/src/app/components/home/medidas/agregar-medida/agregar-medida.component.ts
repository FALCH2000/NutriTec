import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
import { ProductosService } from 'src/app/services/productos.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-agregar-medida',
  templateUrl: './agregar-medida.component.html',
  styleUrls: ['./agregar-medida.component.css']
})
export class AgregarMedidaComponent implements OnInit {

  form: FormGroup;
  titulo = "Registrar Medidas";

  constructor(
    private fb: FormBuilder,
    private _usuarioService: UsuarioService,
    private router: Router,
    private aRoute: ActivatedRoute) {
    this.form = this.fb.group({
      fecha_ingreso: ['', Validators.required],
      cadera: ['', Validators.required],
      cintura: ['', Validators.required],
      cuello: ['', Validators.required],
      peso: ['', Validators.required],
      musculo: ['', Validators.required],
      grasa: ['', Validators.required]
    })
  }

  ngOnInit(): void {
  }

  agregarMedida(){
    if (this.form.invalid){
      return;
    }
    const medida: Object =
    {
      fecha_ingreso: "11/9/2021",
      cadera: Number(this.form.value.cadera),
      cintura: Number(this.form.value.cintura),
      cuello: Number(this.form.value.cuello),
      peso: Number(this.form.value.peso),
      musculo: Number(this.form.value.musculo),
      grasa: Number(this.form.value.grasa),
      cedula_paciente: 33333333
    }
    console.log(medida)
  }

}
