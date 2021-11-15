import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import jsPDF from 'jspdf';

@Component({
  selector: 'app-reporte',
  templateUrl: './reporte.component.html',
  styleUrls: ['./reporte.component.css']
})
export class ReporteComponent implements OnInit {

  constructor(
    private router:Router
  ) { }

  ngOnInit(): void {
    this.generarPDF();
  }

  generarPDF(){
    var doc = new jsPDF();
    doc.setFont('times');
    doc.setFontSize(22);

    doc.text("Reporte de Avance", 100, 20,{align:'center'});
    doc.setFontSize(10);

    doc.setTextColor(150);
    doc.text("A continuación se presenta el reporte de las medias",93, 30, {align:'center'});
    doc.setTextColor(0);
    doc.setFontSize(12);
    doc.setFont('times','normal');
    //Datos de la factura
    doc.text('Numero de factura' ,20, 38);
    doc.save('Reporte.pdf');

    this.router.navigate(['/home/inicio']);
  }
}
