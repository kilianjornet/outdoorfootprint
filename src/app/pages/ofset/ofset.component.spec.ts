import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OfsetComponent } from './ofset.component';

describe('OfsetComponent', () => {
  let component: OfsetComponent;
  let fixture: ComponentFixture<OfsetComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [OfsetComponent]
    });
    fixture = TestBed.createComponent(OfsetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
