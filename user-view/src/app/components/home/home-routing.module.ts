import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AgregarConsumoComponent } from './consumo/agregar-consumo/agregar-consumo.component';
import { ConsumoComponent } from './consumo/consumo.component';
import { HomeComponent } from './home.component';
import { InicioComponent } from './inicio/inicio.component';
import { AgregarMedidaComponent } from './medidas/agregar-medida/agregar-medida.component';
import { MedidasComponent } from './medidas/medidas.component';
import { AgregarProductosComponent } from './productos/agregar-productos/agregar-productos.component';
import { ProductosComponent } from './productos/productos.component';
import { RecetasComponent } from './recetas/recetas.component';
import { ReporteComponent } from './reporte/reporte.component';

const routes: Routes = [
  {path: '', component: HomeComponent, children:[
  { path: 'inicio', component:  InicioComponent},
  { path: 'productos', component:  ProductosComponent},
  { path: 'productos/agregar-producto', component:  AgregarProductosComponent},
  { path: 'medidas', component:  MedidasComponent},
  { path: 'medidas/agregar-medida', component:  AgregarMedidaComponent},
  { path: 'consumo', component:  ConsumoComponent},
  { path: 'consumo/agregar-consumo', component:  AgregarConsumoComponent},
  { path: 'receta', component: RecetasComponent},
  { path: 'reporte', component: ReporteComponent}
  ]},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
