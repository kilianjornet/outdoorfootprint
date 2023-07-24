import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DialogtipsComponent } from './dialogtips.component';

describe('DialogtipsComponent', () => {
  let component: DialogtipsComponent;
  let fixture: ComponentFixture<DialogtipsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DialogtipsComponent]
    });
    fixture = TestBed.createComponent(DialogtipsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
