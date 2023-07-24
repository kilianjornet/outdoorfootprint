import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TpiseditComponent } from './tpisedit.component';

describe('TpiseditComponent', () => {
  let component: TpiseditComponent;
  let fixture: ComponentFixture<TpiseditComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [TpiseditComponent]
    });
    fixture = TestBed.createComponent(TpiseditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
