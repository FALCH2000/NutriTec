import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home.component';
import { InicioComponent } from './inicio/inicio.component';
import { CrearPlanComponent } from './planes/crear-plan/crear-plan.component';
import { PlanesComponent } from './planes/planes.component';
import { AgregarProductoComponent } from './productos/agregar-producto/agregar-producto.component';
import { ProductosComponent } from './productos/productos.component';
import { AsociacionComponent } from './paciente/asociacion/asociacion.component';
import { AsignacionComponent } from './paciente/asignacion/asignacion.component';
import { SeguimientoComponent } from './paciente/seguimiento/seguimiento.component';


const routes: Routes = [
  {path: '', component: HomeComponent, children:[
    { path: 'inicio', component:  InicioComponent},
    { path: 'planes', component:  PlanesComponent},
    { path: 'productos', component:  ProductosComponent},
    { path: 'planes/crear-plan', component:  CrearPlanComponent},
    { path: 'productos/agregar-producto', component:  AgregarProductoComponent},
    {path: 'paciente/asociacion', component: AsociacionComponent},
    {path: 'paciente/asignacion', component: AsignacionComponent},
    {path: 'paciente/seguimiento', component: SeguimientoComponent}
  ]},

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
