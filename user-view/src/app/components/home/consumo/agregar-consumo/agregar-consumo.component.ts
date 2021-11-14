import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
@Component({
  selector: 'app-agregar-consumo',
  templateUrl: './agregar-consumo.component.html',
  styleUrls: ['./agregar-consumo.component.css']
})
export class AgregarConsumoComponent implements OnInit {

  form: FormGroup;
  titulo = "Registrar Comsumo Diario";

  constructor(
    private fb: FormBuilder,
    private _usuarioService: UsuarioService,
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
      merienda_m: this.form.value.merienda_m,
      merienda_t: this.form.value.merienda_t,
      consumo_calorias: Number(this.form.value.consumo_calorias),
      cedula_paciente: 102222345
    }
    console.log(consumo)
    this._usuarioService.addConsumo(consumo)
  }

}
