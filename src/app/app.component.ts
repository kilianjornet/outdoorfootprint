import { Component, OnInit } from '@angular/core';
import { Router, RouteConfigLoadStart, RouteConfigLoadEnd } from '@angular/router';
//import { AdminService } from './services/adminservice.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title(title: any) {
    throw new Error('Method not implemented.');
  }
  loadingRouteConfig: boolean=false;
  constructor(
    //private adminService:AdminService,
    private router:Router
  ){
    console.log('app init');
  }
  ngOnInit(){
    this.router.events.subscribe(event => {
      if (event instanceof RouteConfigLoadStart) {
          this.loadingRouteConfig = true;
          //this.adminService.showLoader();
      } else if (event instanceof RouteConfigLoadEnd) {
          this.loadingRouteConfig = false;
          //this.adminService.hideLoader();
      }
  });
  }
}
