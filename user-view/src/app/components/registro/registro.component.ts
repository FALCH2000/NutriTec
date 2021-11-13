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
  datosPesoForm: FormGroup;
  datosAccesoForm: FormGroup;


  constructor(private fb: FormBuilder,) {
    this.datosPersonalesForm = this.fb.group({
      nombre1: ['', Validators.required],
      nombre2: ['', Validators.required],
      apellido1: ['', Validators.required],
      apellido2: ['', Validators.required],
      cedula: ['', Validators.required],
      pais: ['', Validators.required],
    });
    this.datosPesoForm = this.fb.group({
      imc: ['', Validators.required],
      peso: ['', Validators.required]
    });
    this.datosAccesoForm = this.fb.group({
      email: ['', Validators.required],
      pass: ['', Validators.required],
      passConfirmacion: ['', Validators.required]
    });
   }

  ngOnInit(): void {
  }

  registrarUsuario(){
    const usuario: Object =
    {
      nombre1: this.datosPersonalesForm.value.nombre1,
      nombre2: this.datosPersonalesForm.value.nombre2,
      apellido1: this.datosPersonalesForm.value.apellido1,
      apellido2: this.datosPersonalesForm.value.apellido2,
      cedula: Number(this.datosPersonalesForm.value.cedula),
      fecha_de_nacimiento: "9/8/1990 12:00:00 AM",
      peso: Number(this.datosPesoForm.value.peso),
      estado: "activo",
      edad: 22,
      pass: this.datosAccesoForm.value.pass,
      email: this.datosAccesoForm.value.email,
      imc: Number(this.datosPesoForm.value.imc),
      pais: this.datosPersonalesForm.value.pais,
      codigo_nutricionista: ""
    }
    console.log(usuario)
  }

}
