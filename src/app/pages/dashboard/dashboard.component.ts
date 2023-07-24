import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AdminService } from 'src/app/services/adminservice.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {
  counts:any={
    users: '...',
    interpreters: '...',
    // pending: '...',
    // booking_count: '...',
    // flag_booking_count: '...',
  };
  countLoaded=false;

  analyticsType={
    users: 'users',
    //booking: 'booking'
  }
  totaluser: any;
  list: any;
  totaluser1: any;
  totaluser2: any;
  list1: any;
  cmslist: any;
  allcontent: any;
  allnoti: any;
  constructor(private adminService:AdminService,  private router: Router,) {
    }

  ngOnInit() {
    // this.getData(this.analyticsType.users);
    //this.getData(this.analyticsType.booking);
  this.getuserList();
  this.getcarbonList();
  this.getcartips();
  this.getcms();
  this.getoffset();
  this.getnoti();
  }
 
  getuserList(){
    this.adminService.getuserlist()
    .subscribe((res:any)=>{
      if(res.results){
      this.list=res.results;
      this.totaluser=res.results.length;;
      }else{
     
        this.router.navigateByUrl('/login');
     
        this.adminService.notifyError('something wend wrong')
      }},(Error: any)=> {
    

        //this.toastr.error("Internal server error");
        this.adminService.notifyError("something went wrong please try again");
      }
    )
  }
  getcarbonList(){
    this.adminService.getcarbonlist()
    .subscribe((res:any)=>{
   
      this.totaluser1=res.allUserCalculation.length;
   
    })
  }
  getcartips(){
    this.adminService.showLoader();
    this.adminService.getTips()
    .subscribe((res:any)=>{
   this.adminService.hideLoader();
      this.totaluser2=res.allTips[0].content.length;
     
   
    })
  }
  getcms(){
    this.adminService.getCms()
    .subscribe((res:any)=>{
      this.cmslist=res.allCms.length;

     
   
    })
  }
  getoffset(){
    this.adminService.getOffset()
    .subscribe((res:any)=>{
      this.allcontent=res.all_offset.length;

     
   
    })
  }
  getnoti(){
    this.adminService.getnotification()
    .subscribe((res:any)=>{
  
      this.allnoti=res.all_notification.length;

     
   
    })
  }
}
