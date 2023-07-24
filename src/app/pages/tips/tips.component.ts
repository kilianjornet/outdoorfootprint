import { Component, OnInit, ViewChild } from '@angular/core';
import { AdminService } from '../../services/adminservice.service';
import { Router } from '@angular/router';
import {MatPaginator, MatPaginatorModule} from '@angular/material/paginator';
import {MatSort, MatSortModule} from '@angular/material/sort';
import {MatTableDataSource, MatTableModule} from '@angular/material/table';
import {MatInputModule} from '@angular/material/input';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatIconModule} from '@angular/material/icon';
import {MatButtonModule} from '@angular/material/button';
import {MatToolbarModule} from '@angular/material/toolbar';
import { MatDialog } from '@angular/material/dialog';
import { DialogtipsComponent } from '../dialogtips/dialogtips.component';

import Swal from 'sweetalert2'
@Component({
  selector: 'app-tips',
  templateUrl: './tips.component.html',
  styleUrls: ['./tips.component.css']
})
export class TipsComponent implements OnInit {
  list=[];
  cmslist:any='';
  tipslist:any='';
  cmsedit:any='';
allcontent:any='';
  headerText = ''
  editingMode = false;
  tempHeaderText: string='';
titleid:any='';

editingHeaderText: string='';
  delete: any;

tipsid:any='';
  startEditing() {
    this.editingHeaderText = this.headerText;
    this.editingMode = true;
  }



  cancelEditing() {
 
    this.editingMode = false;
    this.editingHeaderText = this.headerText;
  }
  displayedColumns: string[] = ['id','name','title',  'action'];
  dataSource:any ;
  @ViewChild(MatPaginator) paginator !: MatPaginator 
  @ViewChild(MatSort) sort!:MatSort 
  constructor(
    private adminService:AdminService,
    private router:Router,
    private dialog: MatDialog
  ) { }

  ngOnInit() {

    this.gettips();
  }

  openDialog(): void {
    const dialogRef = this.dialog.open(DialogtipsComponent, {
      width: '600px',
      data: {} // You can pass data to the dialog if needed
    });

    dialogRef.afterClosed().subscribe(result => {
  this.gettips();
    });
  }

  ondelete(element:any){
    
  
    Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'


    }).then((result) => {
      if (result.isConfirmed) {

        try{
         const payload={
          
            "content_id": element._id
        
         }
          this.adminService.deleteTips(this.titleid,payload)
          .subscribe((res:any)=>{
            this.delete=res;
            setTimeout(() => {
              Swal.fire(
                'Deleted successfully',
                "",
                'success'
              ).then((swalResult) => {
                if (swalResult.isConfirmed) {
                  this.gettips();
                }
              });
            }, 10);
            // console.log("The user's Unblock id is", this.unblockresult)
          })
    
       }catch(e){
             this.adminService.hideLoader();
            
             this.adminService.notifyError('Something went wrong');
           }
       

    
      
      }
    })
 
  }


  saveHeader() {
    // Perform any necessary validations here before saving
    this.headerText = this.editingHeaderText;
    this.editingMode = false;
    const payload={
      "tips_title":this.headerText
    }
    
    this.adminService.tipstitlebyid(this.titleid,payload)
    .subscribe((res:any)=>{
    
      if(res.status==true){
        this.adminService.notifySuccess(res.message);
      }else{
        this.adminService.notifyError(res.message);
      }

      this.gettips();
    })
  
  }
 
  onAction(data:any){
    
     this.router.navigateByUrl('/main/tips/tipsedit/'+data._id)
  }
 
  gettips(){
    this.adminService.showLoader();
    try{
this.adminService.getTips()
.subscribe((response:any)=>{
this.adminService.hideLoader();
if(response.status){
  this.headerText=response.allTips[0].tips_title;
this.titleid=response.allTips[0]._id;
  this.allcontent=response.allTips[0].content

  this.dataSource=new MatTableDataSource(this.allcontent);
      this.dataSource.paginator=this.paginator;
      this.dataSource.sort=this.sort;
  // this.dataSource=new MatTableDataSource(this.cmslist);
  //     this.dataSource.paginator=this.paginator;
  //     this.dataSource.sort=this.sort;
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
