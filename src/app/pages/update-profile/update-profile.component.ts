import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { AdminService } from '../../services/adminservice.service';
import { from } from 'rxjs';
import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'app-update-profile',
  templateUrl: './update-profile.component.html',
  styleUrls: ['./update-profile.component.css']
})
export class UpdateProfileComponent implements OnInit {

  profileForm!: FormGroup;
  fetchError = false;
  public firstNme: any = '';
  public lastNme: any = '';
  public gmail: any = '';
  public phNumber: any = '';
  public addr: any = '';
  public profile_image: any = '';
  applicantForm: any;
  imageUrl: any;
  image: any;
  imageEdit: any;

  selectFile: any;
  url: any;
  uId: any
  profileUpdate: any;
  updateuserForm: any;

  constructor(
    public formbuilder: FormBuilder,
    public adminservice: AdminService,
    private router:Router,
    private spiner:NgxSpinnerService) {
  }
  ngOnInit() {
    this.firstNme = localStorage.getItem('firstName');
    this.lastNme = localStorage.getItem('lastName');
    this.gmail = localStorage.getItem('email');
    this.phNumber = localStorage.getItem('phoneNumber');
    this.addr = localStorage.getItem('address');
    this.profile_image = localStorage.getItem('profile_image');

    this.profileForm = this.formbuilder.group({
      firstname: [this.firstNme, Validators.compose([Validators.required, Validators.pattern(/^[a-zA-Z]{2,}$/)])],
      lastname: [this.lastNme, Validators.compose([Validators.required, Validators.pattern(/^[a-zA-Z]{2,}$/)])],//, Validators.compose([Validators.required, Validators.pattern(/^[a-zA-Z]{2,}$/)])],
      email: [this.gmail],
      //profile: this.formbuilder.group({
      phone: [this.phNumber, Validators.compose([Validators.pattern(/^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$/)])],
      address: [this.addr],
      profile_image: [this.profile_image]


      //})
    });

  }

 
  image1(event: any) {

    this.selectFile = event.target.files[0];

    
    var reader = new FileReader
    reader.readAsDataURL(this.selectFile);
    reader.onload = (event: any) => {
      this.url =
        this.url = event.target.result;
      // console.log("url"+this.url)
    }

    // this.updateuserForm.get('profile_image')?.setValue(this.selectFile) as unknown as FormControl;

    // console.log(this.selectFile);


  }

  onUpdate() {
  //  this.adminservice.showLoader();
    this.uId = localStorage.getItem('id');


    const fdata = new FormData();
    if (this.selectFile) {

      fdata.append('profile_image', this.selectFile);
    }
    fdata.append('firstName', this.profileForm.controls?.["firstname"].value);
    fdata.append('lastName', this.profileForm.controls?.["lastname"].value);
    // fdata.append('email', this.profileForm.controls?.["email"].value);
    // fdata.append('phone', this.profileForm.controls?.["phone"].value);
    fdata.append('address', this.profileForm.controls?.["address"].value);
    fdata.append('userId', this.uId);




  

    this.adminservice.profileUpdate(fdata)
      .subscribe((res: any) => {
      
    // this.adminservice.hideLoader();
        localStorage.setItem('profileData', JSON.stringify(res.user));
    
        // Emit an event to notify subscribers
        this.adminservice.updateProfileData(res.user);

        localStorage.setItem('firstName',res.user.firstName);
        localStorage.setItem('lastName',res.user.lastName);
        localStorage.setItem('email',res.user.email);
        // localStorage.setItem('role',res.role);
        localStorage.setItem('address',res.user.address);
        localStorage.setItem('phoneNumber',res.user.phoneNumber);
        // localStorage.setItem('id',res.id);
        localStorage.setItem('profile_image',res.user.profile_image);
        //  window.location.reload();
     
        this.firstNme = localStorage.getItem('firstName');
        this.lastNme = localStorage.getItem('lastName');
        this.gmail = localStorage.getItem('email');
        this.phNumber = localStorage.getItem('phoneNumber');
        this.addr = localStorage.getItem('address');
        this.profile_image = localStorage.getItem('profile_image');
        // this.router.navigate(['/main/dashboard']);
      })

    this.adminservice.notifySuccess("Admin profile updated successfully");
    
    // Swal.fire("Hey!!,Update Complete","Refresh Page  Seen Updated Profile");

  }









}
