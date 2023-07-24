

import { Component, OnInit, ViewChild, ViewContainerRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
// import { ForgotpassComponent } from '../forgotpass/forgotpass.component';
import { ActivatedRoute, Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';
import { AdminService } from '../../services/adminservice.service';
// import { TextInputDialogComponent } from 'src/app/components/text-input-dialog/text-input-dialog.component';
import { HttpClient } from '@angular/common/http';
//import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-vpass',
  templateUrl: './vpass.component.html',
  styleUrls: ['./vpass.component.css']
})
export class VpassComponent implements OnInit {
  base_url = '';
  forgotForm: any;
  public snapshotEmail: any;
  otp: any='';
  showOtpComponent = true;
  @ViewChild('ngOtpInput', { static: false}) ngOtpInput: any;
  config = {
    allowNumbersOnly: false,
    length: 6,
    isPasswordInput: false,
    disableAutoFocus: false,
    placeholder: '',
    inputStyles: {
      'width': '50px',
      'height': '50px'
    }
  };
  onOtpChange(otp:any) {
    this.otp = otp;
  
    this.forgotForm = this.formbuilder.group({
      email: [this.snapshotEmail],
      role: ['admin'],
      otp: this.otp,
    });

  }



  toggleDisable(){
    if(this.ngOtpInput.otpForm){
      if(this.ngOtpInput.otpForm.disabled){
        this.ngOtpInput.otpForm.enable();
      }else{
        this.ngOtpInput.otpForm.disable();
      }
    }
  }

  onConfigChange() {
    this.showOtpComponent = false;
    this.otp = null;
    setTimeout(() => {
      this.showOtpComponent = true;
    }, 0);
  }
  constructor(
    public formbuilder: FormBuilder,
    public dialog: MatDialog,
    public adminservice: AdminService,
    private router: Router,
    private route: ActivatedRoute,
    //public toastr: ToastrService, 
    //vcr: ViewContainerRef,
    private spinnerService: NgxSpinnerService,
    private http:HttpClient
  ) {
 
    //this.toastr.(vcr);
 
  }

  ngOnInit() {
    this.route.paramMap.subscribe((params) => {
      this.snapshotEmail = params.get('email');
    
      
    });
   }

  onBack(){
    this.router.navigateByUrl('/login');
}

  onreset(){
   var token:any='';

    this.adminservice.verifypass(this.forgotForm.value)
    .subscribe((response:any)=>{

      if(response.status==true){
          token=response.token;
        this.router.navigate(['/newpass',token ]);
      }
    })
  }
       
    
       
    
    
  
 
}


