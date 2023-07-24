import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  AbstractControl,
  ValidatorFn,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AdminService } from '../../services/adminservice.service';

@Component({
  selector: 'app-newpass',
  templateUrl: './newpass.component.html',
  styleUrls: ['./newpass.component.css']
})
export class NewpassComponent {
  changepasswordForm:any='';
  public token:any='';


  constructor(
    public formbuilder: FormBuilder,
    public adminservice: AdminService,
    private router: Router,
    private route:ActivatedRoute
  ) {
    
  }

  ngOnInit() {
    this.route.paramMap.subscribe((params) => {
      this.token = params.get('token');
      this.changepasswordForm = this.formbuilder.group({
      
        token: this.token,
         password: [''],
      });
      
    });
  }


  onreset() {

    
    this.adminservice.resetPass(this.changepasswordForm.value)
    .subscribe((res:any)=>{
   
      this.adminservice.notifySuccess(res.message);
      this.router.navigateByUrl('/login');
    })
  }
  onBack(){
    this.router.navigateByUrl('/login');
  }



}
