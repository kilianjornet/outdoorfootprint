import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VpassComponent } from './vpass.component';

describe('VpassComponent', () => {
  let component: VpassComponent;
  let fixture: ComponentFixture<VpassComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [VpassComponent]
    });
    fixture = TestBed.createComponent(VpassComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
