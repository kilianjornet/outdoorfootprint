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
  selector: 'app-p-notification',
  templateUrl: './p-notification.component.html',
  styleUrls: ['./p-notification.component.css']
})



export class PNotificationComponent implements OnInit {
  updateuserForm:any='';

  logintoken: any = '';

  public userId: any;
  public edit_user: any;
  url: any = '';
  selectfile: any = '';
  profile: any = '';
  item: any;
  public data2: any = '';
  imgurl: any = "https://media.istockphoto.com/id/1447392952/vector/user-icon-vector-design-illustration.jpg?s=612x612&w=0&k=20&c=kODxcASgElE3iTzKSCXh-zclZ_UVKRmqDhYVif1W8Z8="
  getUserAllId: any;
  constructor(private route: ActivatedRoute, private http: HttpClient,
    public formbuilder: FormBuilder,
    public adminservice: AdminService,
    private router: Router,
    private spinnerService: NgxSpinnerService) {

    this.updateuserForm = this.formbuilder.group({

      title:[''],
      content:['']
      

    });
  }
  ngOnInit() {

    this.logintoken = localStorage.getItem('token');
    this.edit_user = this.route.snapshot.paramMap.get('id');
    
  


  }
  onSend() {
    this.adminservice.showLoader();
 
    this.adminservice.sendNotification(this.updateuserForm.value)
    .subscribe((res:any)=>{

      this.adminservice.hideLoader();
      if(res.status){
        this.adminservice.notifySuccess(res.message);
      } else{
        this.adminservice.notifyError(res.message);
      }
     
     
    });
   

    // this.adminservice.sendNotification()
  }

 
 
 

}

