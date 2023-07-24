import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  AbstractControl,
  ValidatorFn,
} from '@angular/forms';
import { Router } from '@angular/router';
import { AdminService } from '../../services/adminservice.service';

@Component({
  selector: 'app-changepassword',
  templateUrl: './changepassword.component.html',
  styleUrls: ['./changepassword.component.css'],
})
export class ChangepasswordComponent implements OnInit {
  
  changepasswordForm: FormGroup;

  constructor(
    public formbuilder: FormBuilder,
    public adminservice: AdminService,
    private router: Router
  ) {
    this.changepasswordForm = formbuilder.group({
      currentpassword: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(15),
        ]),
      ],
      newpassword: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(15),
        ]),
      ],
      confirmnewpassword: [
        '',
        Validators.compose([Validators.required, this.equalto('password')]),
      ],
    });
  }

  ngOnInit() {}

  async changepass() {
    this.adminservice.showLoader();
    
  }

 
  equalto(confirmnewpassword: string): ValidatorFn {
    return (control: AbstractControl): { [key: string]: any } | null => {
      const input = control.value;
      const isValid = control.root.get(confirmnewpassword)?.value === input;
      if (!isValid) {
        return { equalTo: { isValid } };
      } else {
        return null;
      }
    };
  }
}
