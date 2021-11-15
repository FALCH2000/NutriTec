import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-medidas',
  templateUrl: './medidas.component.html',
  styleUrls: ['./medidas.component.css']
})
export class MedidasComponent implements OnInit {
  range = new FormGroup({
    start: new FormControl(),
    end: new FormControl(),
  });
  constructor() { }

  ngOnInit(): void {
  }

  getFechas(){
    let inicio= new Date(this.range.value.start);
    let final= new Date(this.range.value.end);
    
    let dayInicio = inicio.getDate()
    let monthInicio = inicio.getMonth() + 1
    let yearInicio = inicio.getFullYear()

    let dayFinal = final.getDate()
    let monthFinal = final.getMonth() + 1
    let yearFinal = final.getFullYear()
    let fechaInicio:string;
    let fechaFinal:string;
    if(monthInicio < 10){
      fechaInicio= `${dayInicio}/0${monthInicio}/${yearInicio}`;
    }else{
      fechaInicio= `${dayInicio}/${monthInicio}/${yearInicio}`;
    }

    if(monthFinal < 10){
      fechaFinal=`${dayFinal}/0${monthFinal}/${yearFinal}`;
    }else{
      fechaFinal=`${dayFinal}/${monthFinal}/${yearFinal}`;
    }

    console.log("Es de: "+ fechaInicio+" hasta "+ fechaFinal);
      }

}
