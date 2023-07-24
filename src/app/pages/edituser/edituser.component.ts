import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
import { AdminService } from '../../services/adminservice.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'app-edituser',
  templateUrl: './edituser.component.html',
  styleUrls: ['./edituser.component.css'],
})
export class EdituserComponent implements OnInit {
  updateuserForm!: FormGroup;

  logintoken: any = '';

  public userId: any;
  public edit_user: any;
  url: any = '';
  selectfile: any = '';
  profile: any = '';
  item: any;
  public data2:any='';
imgurl:any="https://media.istockphoto.com/id/1447392952/vector/user-icon-vector-design-illustration.jpg?s=612x612&w=0&k=20&c=kODxcASgElE3iTzKSCXh-zclZ_UVKRmqDhYVif1W8Z8="
  constructor(private route: ActivatedRoute,private http:HttpClient,
    public formbuilder: FormBuilder,
    public adminservice: AdminService,
    private router:Router,
    private spinnerService: NgxSpinnerService) {
    
      this.updateuserForm = this.formbuilder.group({
        firstName: ['', Validators.compose([Validators.required])],
        lastName: ['', Validators.compose([Validators.required])],
        email : ['', Validators.compose([Validators.required, Validators.pattern(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)])],
        phoneNumber: [''],
        address:[''],
        profile_image:[''],
        
      });
  }
  ngOnInit() {
    this.logintoken = localStorage.getItem('token');
    this.edit_user = this.route.snapshot.paramMap.get('id');
    // this.loadData();
    this.loaddata1();
  }

  // Dynamic call class //
  public get profile_image() {
    // class property
    return this.updateuserForm.get('profile_image') as FormControl;
  }
  public get firstName() {
    // class property
    return this.updateuserForm.get('firstName') as FormControl;
  }

  public get lastName() {
    // class property
    return this.updateuserForm.get('lastName') as FormControl;
  }

  public get phoneNumber() {
    // class property
    return this.updateuserForm.get('phoneNumber') as FormControl;
  }

  public get email() {
    // class property
    return this.updateuserForm.get('email') as FormControl;
  }

  public get address() {
    return this.updateuserForm.get('address') as FormControl;
  }

  /*---fle/photo---*/
  image1(event: any) {

    this.selectfile = event.target.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(this.selectfile);
    reader.onload = (event: any) => {
      this.url = this.url = event.target.result;
      // console.log("url"+this.url)
    };

    this.updateuserForm
      .get('profile_image')
      ?.setValue(this.selectfile) as unknown as FormControl;
 
  }
loaddata1(){
  this.spinnerService.show();
  this.adminservice.getuser(this.edit_user)
  .subscribe((res:any)=>{
    this.spinnerService.hide();
 
this.item=res;
this.data2 = res.firstName + ' ' + res.lastName;
this.profile=res.profile_image

this.updateuserForm.patchValue(res);

  })
}
  updateuserData(){
 
const formData = new FormData();
  formData.append('profile_image', this.selectfile);
  formData.append('userId', this.edit_user);
  formData.append('firstName', this.updateuserForm.controls?.['firstName'].value);
  formData.append('lastName', this.updateuserForm.controls?.['lastName'].value);
  formData.append('address', this.updateuserForm.controls?.['address'].value);

    try {
      this.adminservice.userupdate(formData).subscribe((res: any) => {

        this.adminservice.notifySuccess('User account details have been saved');
        this.router.navigate(['/main/users']);
      });
    } catch (error) {
 
      this.adminservice.showToast('something went wrong please try again ');
    }
  }
}
