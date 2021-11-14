import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AgregarConsumoComponent } from './agregar-consumo.component';

describe('AgregarConsumoComponent', () => {
  let component: AgregarConsumoComponent;
  let fixture: ComponentFixture<AgregarConsumoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AgregarConsumoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AgregarConsumoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
