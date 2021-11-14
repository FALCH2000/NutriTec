import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home.component';
import { InicioComponent } from './inicio/inicio.component';
import { ProductosComponent } from './productos/productos.component';
import { PaginaComponent } from './reporte/pagina/pagina.component';
import { GenerarPDFComponent } from './reporte/generar-pdf/generar-pdf.component';


const routes: Routes = [
  {path: '', component: HomeComponent, children:[
    { path: 'inicio', component:  InicioComponent},
    { path: 'productos', component:  ProductosComponent},
    {path: 'reporte', component:PaginaComponent},
    {path: 'pdf', component:GenerarPDFComponent}
  ]},

];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
