import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CarbonmanagementComponent } from './carbonmanagement.component';

describe('CarbonmanagementComponent', () => {
  let component: CarbonmanagementComponent;
  let fixture: ComponentFixture<CarbonmanagementComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CarbonmanagementComponent]
    });
    fixture = TestBed.createComponent(CarbonmanagementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
