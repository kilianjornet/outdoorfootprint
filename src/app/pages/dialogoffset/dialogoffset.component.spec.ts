import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DialogoffsetComponent } from './dialogoffset.component';

describe('DialogoffsetComponent', () => {
  let component: DialogoffsetComponent;
  let fixture: ComponentFixture<DialogoffsetComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DialogoffsetComponent]
    });
    fixture = TestBed.createComponent(DialogoffsetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
