import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GenerarPDFComponent } from './generar-pdf.component';

describe('GenerarPDFComponent', () => {
  let component: GenerarPDFComponent;
  let fixture: ComponentFixture<GenerarPDFComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ GenerarPDFComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(GenerarPDFComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
