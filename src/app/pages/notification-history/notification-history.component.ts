import { Component, OnInit, ViewChild } from '@angular/core';
import { AdminService } from '../../services/adminservice.service';
import { Router } from '@angular/router';
import {MatPaginator, MatPaginatorModule} from '@angular/material/paginator';
import {MatSort, MatSortModule} from '@angular/material/sort';
import {MatTableDataSource, MatTableModule} from '@angular/material/table';


@Component({
  selector: 'app-notification-history',
  templateUrl: './notification-history.component.html',
  styleUrls: ['./notification-history.component.css']
})
export class NotificationHistoryComponent implements OnInit {
  @ViewChild(MatPaginator) paginator !: MatPaginator 
  list=[];
  cmslist:any='';
  tipslist:any='';
  cmsedit:any='';
allcontent:any='';
 displayedColumns: string[] = ['id','send','title','content','create','update'];
  dataSource:any ;

  constructor(
    private adminService:AdminService,
    private router:Router
  ) { }

  ngOnInit() {

    this.gettips();
  }

  gettips(){
    this.adminService.showLoader();
    try{
this.adminService.getnotification()
.subscribe((response:any)=>{
this.adminService.hideLoader();
if(response.status){


  this.allcontent=response.all_notification;

  this.dataSource=new MatTableDataSource(this.allcontent);
  this.dataSource.paginator=this.paginator;

}else{
  this.adminService.notifyError(response.message);
}
})
    } catch(e){
this.adminService.notifySuccess("Something went wrong")
    }
  }
 
  pageSize = 10; // Set the initial number of items per page
pageSizeOptions: number[] = [5, 10, 20,30,50,100,200]; // Set the available options for items per page

onPageChange(event: any) {
  // Reset the paginator's index to 0 when changing the page
  this.paginator.pageIndex = event.pageIndex;
}

getAdjustedIndex(index: number): number {
  // Calculate the adjusted index based on the current page and number of items per page
  return index + this.paginator.pageIndex * this.paginator.pageSize;
}
}
