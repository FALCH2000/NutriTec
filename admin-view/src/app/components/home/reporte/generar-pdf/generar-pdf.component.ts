import { Component, OnInit } from '@angular/core';
import { CobroService } from 'src/app/services/cobro.service';
import { Router } from '@angular/router';
import jsPDF from 'jspdf';

@Component({
  selector: 'app-generar-pdf',
  templateUrl: './generar-pdf.component.html',
  styleUrls: ['./generar-pdf.component.css']
})
export class GenerarPDFComponent implements OnInit {
  listCobros: Cobros[] = [];
  constructor(
    private _cobroService: CobroService,
    private router:Router
  ) { }

  ngOnInit(): void {
    this.cargarCobro();
  }
  generarPDF(){
    const doc = new jsPDF();
    
    doc.setFont('times');
    doc.setFontSize(22);
    let varsi="No.1: Cantidad de pacientes\nNo.2: Descuento\nNo.3: Monto de Cobro\nNo.4: Monto Total";
    doc.text("Reporte de Avance", 100, 20,{align:'center'});

    doc.setTextColor(150);
    doc.setFontSize(10);
    
    doc.text("Tome en cuenta la simbología\n"+varsi,15, 40,{align:'left'});
    

    

    doc.setTextColor(150);
    doc.text("A continuación se presenta el reporte de cobro para cada nutricionista",95, 30,
     {align:'center'});
    doc.setTextColor(0);
    doc.setFontSize(11);
    doc.setFont('times','normal');
    //Datos de la factura
    let counter=0;
    let posX=15;
    let posY=85;
    
    doc.setLineWidth(0.6);
    doc.line(15, 65, 200, 65);
    // ENCABEZADOS DE LA TABLA
    doc.text("Nombre" ,15, 70);
    doc.text("Codigo" ,45, 70);
    doc.text("Email" ,65, 70);
    doc.text("No. Tarjeta" ,100, 70);
    doc.text("Tipo" ,125, 70);
    doc.text("No.1" ,145, 70); //Cantidad de pacientes
    doc.text("No.2" ,160, 70); //Descuento
    doc.text("No.3" ,175, 70); // Monto Cobro
    doc.text("No.4",190, 70); // Total cantidad

    doc.line(15, 77, 200, 77);
    doc.setLineWidth(0.4);

    doc.setFontSize(9);
    while(this.listCobros[counter]!=undefined){

      doc.text(this.listCobros[counter].nombre ,posX, posY);
      doc.text(this.listCobros[counter].codigo_nutricionista ,posX+30, posY);
      doc.text(this.listCobros[counter].email ,posX+50, posY);
      doc.text(this.listCobros[counter].numero_tarjeta.toString() ,posX+87, posY);
      doc.text(this.listCobros[counter].tipo_cobro ,posX+110, posY);
      doc.text(this.listCobros[counter].cantidad_pacientes.toString() ,posX+130, posY);
      doc.text(this.listCobros[counter].descuento.toString() ,posX+145, posY);
      doc.text(this.listCobros[counter].monto_cobro.toString() ,posX+160, posY);
      doc.text(this.listCobros[counter].monto_total.toString() ,posX+175, posY);
      doc.line(15, posY+10, 200, posY+10);

      counter++;
      posY +=20;
    }

    
    
    doc.save('ReporteDeCobro.pdf');

    this.router.navigate(['home/reporte']);
  }
  

  cargarCobro(){
    
    this._cobroService.getCobros().subscribe(
      result=> {
        var counter=0;
        while(result[counter]!=undefined){
          this.insertCobro(result[counter]);
          counter++;
        }
        this.generarPDF();
        
      },
      error=>{
        alert("Error con el cobro");
        console.log("eroror en cobro"+<any>error);
      }
    )
  }

  insertCobro(cobro:any){
    var cobroNuevo:Cobros= {
      tipo_cobro: cobro.tipo_cobro,
      codigo_nutricionista: cobro.codigo_nutricionista,
      email: cobro.email,
      nombre: cobro.nombre1+" " + cobro.nombre2+"\n"+cobro.apellido1+" "+cobro.apellido2,
      numero_tarjeta: cobro.numero_tarjeta,
      cantidad_pacientes: cobro.cantidad_pacientes,
      monto_total: cobro.monto_total,
      descuento: cobro.descuento,
      monto_cobro: cobro.monto_cobro
    }
    this.listCobros.push(cobroNuevo);
  }

}

export interface Cobros{
  tipo_cobro: string,
  codigo_nutricionista: string,
  email: string,
  nombre: string,
  numero_tarjeta: number,
  cantidad_pacientes: number,
  monto_total: number,
  descuento: number,
  monto_cobro: number
}
