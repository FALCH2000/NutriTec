import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NutriService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-registro',
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.css']
})
export class RegistroComponent implements OnInit {
  isLinear = false;
  datosPersonalesForm: FormGroup;
  datosPagoForm: FormGroup;
  datosAccesoForm: FormGroup;

  constructor(private fb: FormBuilder,
              private _usuarioService: NutriService) {
    this.datosPersonalesForm = this.fb.group({
      nombre1: ['', Validators.required],
      nombre2: ['', Validators.required],
      apellido1: ['', Validators.required],
      apellido2: ['', Validators.required],
      cedula: ['', Validators.required],
      codigo_nutricionista: ['', Validators.required],
      direccion: ['', Validators.required],
    });
    this.datosPagoForm = this.fb.group({
      numeroTarjeta: ['', Validators.required],
      tipoPago: ['', Validators.required]
    });
    this.datosAccesoForm = this.fb.group({
      email: ['', Validators.required],
      pass: ['', Validators.required],
      passConfirmacion: ['', Validators.required]
    });
   }

  ngOnInit(): void {
  }

  registrarNutricionista(){
    const nutricionista: Object =
    {
      nombre1: this.datosPersonalesForm.value.nombre1,
      nombre2: this.datosPersonalesForm.value.nombre2,
      apellido1: this.datosPersonalesForm.value.apellido1,
      apellido2: this.datosPersonalesForm.value.apellido2,
      cedula: Number(this.datosPersonalesForm.value.cedula),
      fecha_de_nacimiento: "9/8/1990 12:00:00 AM",
      edad: 22,
      codigo_nutricionista: this.datosPersonalesForm.value.codigo_nutricionista,
      pass: this.datosAccesoForm.value.pass,
      email: this.datosAccesoForm.value.email,
      numero_tarjeta: Number(this.datosPagoForm.value.numeroTarjeta),
      tipo_cobro: "Mensual",
      rol: "Nutricionista",
      direccion: this.datosPersonalesForm.value.direccion,
      foto: "url"
    }
    this._usuarioService.postNutricionista(nutricionista);
  }
}
