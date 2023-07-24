import { Component, OnInit, ViewChild, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { MatSidenav } from '@angular/material/sidenav';
import { AdminService } from '../../services/adminservice.service';
// import { ChatService } from 'src/app/services/chat.service';
import { Subscription } from 'rxjs';
//import { ToastsManager } from 'ng2-toastr';



@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.css'],
})
export class MainComponent implements OnInit, OnDestroy {
  notificationCount = 0;
  chatHistoryCount = 0;
  totalBadgeCount = 0;
  currentChatUser = '';
  isChatHistoryPage = false;
  public loggedUser: any = '';
  public loggedUserLastName: any = ''
  public profile_image:any='';
  public url:any;
  profileData:any='';
  constructor(
    public router: Router,
    private adminService: AdminService,
    // private chatService: ChatService
  ) {

  }
  @ViewChild(MatSidenav) sidenav!: MatSidenav;

  ngOnInit() {
 
    const profileDataString = localStorage.getItem('profileData');
    if (profileDataString) {
      const profileData = JSON.parse(profileDataString);
      this.loggedUser =profileData.firstName;
      this.loggedUserLastName=profileData.lastName;
      this.profile_image = profileData.profile_image;
    }
    this.adminService.profileData$.subscribe((data:any)=>{
      
      this.profileData = data;

      this.loggedUser= this.profileData.firstName;

      this.loggedUserLastName =this.profileData.lastName;
      this.profile_image=this.profileData.profile_image;

  
    })
      
    

 
    
  
   

   
}
 
  ngOnDestroy() {
  }

  

  isLargeScreen() {
    const width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    if (width > 1024) {
      return true;
    } else {
      return false;
    }
  }
  isSmallScreen() {
    const width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    if (width < 1024) {
      this.sidenav.close();
    }
  }

  logOut() {
    
    this.adminService.logout();

  }
  login(){
    if(localStorage.getItem('token')){
      return true;

    }
    else{ return false}

}
}
