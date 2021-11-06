import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { RegistroComponent } from './components/registro/registro.component';


const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'registro', component: RegistroComponent},
  { path: 'home', loadChildren:() => import('./components/home/home.module').then(x => x.HomeModule)},
  { path: '**', redirectTo: 'login', pathMatch: 'full'}

];
@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
