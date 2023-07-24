
import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';

import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';
import { AdminService } from '../../services/adminservice.service';
import { HttpClient } from '@angular/common/http';
import {MatIconModule} from '@angular/material/icon';
import {MatDividerModule} from '@angular/material/divider';
import {MatButtonModule} from '@angular/material/button';
//import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-forgotpassword',
  templateUrl: './forgotpassword.component.html',
  styleUrls: ['./forgotpassword.component.css']
})
export class ForgotpasswordComponent implements OnInit {
  base_url = '';
  forgotForm: FormGroup;

  constructor(
    public formbuilder: FormBuilder,
    public dialog: MatDialog,
    public adminservice: AdminService,
    private router: Router,
    //public toastr: ToastrService, 
    //vcr: ViewContainerRef,
    private spinnerService: NgxSpinnerService,
    private http:HttpClient
  ) {
    this.base_url = this.adminservice.api;
    //this.toastr.(vcr);
    this.forgotForm = formbuilder.group({
      email: ['', Validators.compose([Validators.required,Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$')])],
     role:['admin']
    });
  }

  ngOnInit() { }

  onBack(){
      this.router.navigateByUrl('/login');
  }

  onreset() {
    var email: any = this.forgotForm.controls?.["email"].value;
    try {
      const fdata = new FormData();
      fdata.append('email', this.forgotForm.controls?.["email"].value);
      this.adminservice.forgotPass(this.forgotForm.value).subscribe(
        (response: any) => {
          if (response.status) {
            this.adminservice.notifySuccess(response.message);
       
            this.router.navigate(['/vpass', email]);
          } else {
            this.adminservice.notifyError(response.message);
       
            this.adminservice.hideLoader();
          }
        },
        (error) => {
      
          this.adminservice.notifyError("Please check"); // Display the error message to the user
        }
      );
    } catch (e) {
     
      this.adminservice.notifyError("Error occurred"); // Display a generic error message to the user
    }
  }
}


