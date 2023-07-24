import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OffseteditComponent } from './offsetedit.component';

describe('OffseteditComponent', () => {
  let component: OffseteditComponent;
  let fixture: ComponentFixture<OffseteditComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [OffseteditComponent]
    });
    fixture = TestBed.createComponent(OffseteditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
