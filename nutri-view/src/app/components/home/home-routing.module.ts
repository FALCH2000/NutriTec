import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home.component';
import { InicioComponent } from './inicio/inicio.component';
import { CrearPlanComponent } from './planes/crear-plan/crear-plan.component';
import { PlanesComponent } from './planes/planes.component';
import { ProductosComponent } from './productos/productos.component';

const routes: Routes = [
  {path: '', component: HomeComponent, children:[
    { path: 'inicio', component:  InicioComponent},
    { path: 'planes', component:  PlanesComponent},
    { path: 'productos', component:  ProductosComponent},
    { path: 'planes/crear-plan', component:  CrearPlanComponent},
  ]},

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
