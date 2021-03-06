import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import { NavbarComponent } from './navbar/navbar.component';
import { InicioComponent } from './inicio/inicio.component';
import { ProductosComponent } from './productos/productos.component';
import { PlanesComponent } from './planes/planes.component';
import { SharedModule } from '../shared/shared.module';
import { CrearPlanComponent } from './planes/crear-plan/crear-plan.component';
import { AgregarProductoComponent } from './productos/agregar-producto/agregar-producto.component';
import { AsociacionComponent } from './paciente/asociacion/asociacion.component';
import { AsignacionComponent } from './paciente/asignacion/asignacion.component';
import { SeguimientoComponent } from './paciente/seguimiento/seguimiento.component';



@NgModule({
  declarations: [
    HomeComponent,
    NavbarComponent,
    InicioComponent,
    ProductosComponent,
    PlanesComponent,
    CrearPlanComponent,
    AgregarProductoComponent,
    AsociacionComponent,
    AsignacionComponent,
    SeguimientoComponent
  ],
  imports: [
    CommonModule,
    HomeRoutingModule,
    SharedModule
    
  ]
})
export class HomeModule { }
