import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import { ProductosComponent } from './productos/productos.component';
import { InicioComponent } from './inicio/inicio.component';
import { NavbarComponent } from './navbar/navbar.component';
import { SharedModule } from '../shared/shared.module';
import { PaginaComponent } from './reporte/pagina/pagina.component';
import { GenerarPDFComponent } from './reporte/generar-pdf/generar-pdf.component';


@NgModule({
  declarations: [
    HomeComponent,
    ProductosComponent,
    InicioComponent,
    NavbarComponent,
    PaginaComponent,
    GenerarPDFComponent
  ],
  imports: [
    CommonModule,
    HomeRoutingModule,
    SharedModule
  ]
})

/**
 * Clase para el modulo Home
 * @author Carmen Araya
 * */
export class HomeModule { }
