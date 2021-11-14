import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import { InicioComponent } from './inicio/inicio.component';
import { NavbarComponent } from './navbar/navbar.component';
import { SharedModule } from '../shared/shared.module';
import { ProductosComponent } from './productos/productos.component';
import { AgregarProductosComponent } from './productos/agregar-productos/agregar-productos.component';
import { MedidasComponent } from './medidas/medidas.component';
import { ConsumoComponent } from './consumo/consumo.component';
import { AgregarConsumoComponent } from './consumo/agregar-consumo/agregar-consumo.component';
import { AgregarMedidaComponent } from './medidas/agregar-medida/agregar-medida.component';


@NgModule({
  declarations: [
    HomeComponent,
    InicioComponent,
    NavbarComponent,
    ProductosComponent,
    AgregarProductosComponent,
    MedidasComponent,
    ConsumoComponent,
    AgregarConsumoComponent,
    AgregarMedidaComponent
  ],
  imports: [
    CommonModule,
    HomeRoutingModule,
    SharedModule
  ],
  entryComponents: [AgregarConsumoComponent]
})
export class HomeModule { }
