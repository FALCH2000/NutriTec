import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

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

  constructor(private fb: FormBuilder,) {
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

}
