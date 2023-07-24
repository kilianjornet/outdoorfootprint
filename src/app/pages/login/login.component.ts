import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';
import { AdminService } from 'src/app/services/adminservice.service';
// import { AdminService } from 'src/app/services/adminservice.service';


//import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  base_url = '';
  loginForm: FormGroup;

  constructor(
    public formbuilder: FormBuilder,
    public adminservice: AdminService,
  
    private router: Router,

    private spinnerService: NgxSpinnerService,
 
  ) {
   
    //this.toastr.(vcr);
    this.loginForm = formbuilder.group({
      email: ['', Validators.compose([Validators.required,Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$')])],
      password: ['', Validators.compose([Validators.required, Validators.minLength(6), Validators.maxLength(15)])]
    });
  }

  ngOnInit() { }

  async doLogin() {
    //this.openDialog2FA();
    //return;
    this.spinnerService.show();
    let formValue = this.loginForm.value;

    try {
      let response = await this.adminservice.loginService(formValue);
      this.spinnerService.hide();
  
      if (response.tokens) {
        // this.router.navigateByUrl('forgotpassword');
        localStorage.setItem('profileData', JSON.stringify(response.user));
        localStorage.setItem('firstName',response.user.firstName);
        localStorage.setItem('lastName',response.user.lastName);
        localStorage.setItem('email',response.user.email);
        localStorage.setItem('role',response.user.role);
        localStorage.setItem('address',response.user.address);
        localStorage.setItem('phoneNumber',response.user.phoneNumber);
        localStorage.setItem('id',response.user.id);
        localStorage.setItem('profile_image',response.user.profile_image);
        //this.toastr.success(response.message);
      
        this.adminservice.notifySuccess("Login Success!");
        if (response.tokens.access.token)
          this.router.navigateByUrl('/main/dashboard');
      
      } else {
  
        //this.toastr.error(response.message);
        this.adminservice.showToast(response.message);
      }
    } catch (e) {
      this.spinnerService.hide();
   
      //this.toastr.error("Internal server error");
      this.adminservice.notifyError("something went wrong please try again");
    }
  }

  // eye icon 
  changetype: boolean = true;
  visible :boolean =true;
  viewpass(){
  this.visible = !this.visible;
  this.changetype = !this.changetype;}
  type: string='password';
  isText:boolean=false;
  eyeIcon:string='fa-eye-slash';


 
}


