import { Component, OnInit, ViewChild } from '@angular/core';
import { AdminService } from '../../services/adminservice.service';
import { Router } from '@angular/router';
import {MatPaginator, MatPaginatorModule} from '@angular/material/paginator';
import {MatSort, MatSortModule} from '@angular/material/sort';
import {MatTableDataSource, MatTableModule} from '@angular/material/table';
import {MatInputModule} from '@angular/material/input';
import {MatFormFieldModule} from '@angular/material/form-field';
import { MatDialog } from '@angular/material/dialog';
import { DialogcmsComponent } from '../dialogcms/dialogcms.component';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-cms-list',
  templateUrl: './cms-list.component.html',
  styleUrls: ['./cms-list.component.css']
})
export class CmsListComponent implements OnInit {
  list=[];
  cmslist:any='';
  cmsedit:any='';

 
  displayedColumns: string[] = ['name','title',  'update','action'];
  dataSource:any ;
  @ViewChild(MatPaginator) paginator !: MatPaginator 
  @ViewChild(MatSort) sort!:MatSort 
  constructor(
    private adminService:AdminService,
    private router:Router,    private dialog: MatDialog
  ) { }

  ngOnInit() {
    this.getcms();
  }

 
  onAction(data:any){
    
     this.router.navigateByUrl('/main/cms/edit/'+data.id)
  }

  getcms(){
     this.adminService.showLoader();
     try{
     this.adminService.getCms().subscribe((res:any)=>{
      this.adminService.hideLoader();

if(res.status){
  this.cmslist=res.allCms;
  this.dataSource=new MatTableDataSource(this.cmslist);
      this.dataSource.paginator=this.paginator;
      this.dataSource.sort=this.sort;

  // this.adminService.notifySuccess(res.message);


}else{
  this.adminService.notifyError('Something went wrong');
}

     })
     
    
  
    }catch(e){
      this.adminService.hideLoader();

      this.adminService.notifyError('Something went wrong');
    }
  }
  
  openDialog(): void {
    const dialogRef = this.dialog.open(DialogcmsComponent, {
      width: '600px',
      data: {} // You can pass data to the dialog if needed
    });

    dialogRef.afterClosed().subscribe(result => {
      // The result contains the form data when the dialog is closed
      console.log('Dialog result:', result);
      this.getcms();
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
        
          this.adminService.deletecms(element._id,{})
          .subscribe((res:any)=>{
            this.ondelete=res;
            setTimeout(() => {
              Swal.fire(
                'Deleted successfully',
                "",
                'success'
              ).then((swalResult) => {
                if (swalResult.isConfirmed) {
                  this.getcms();
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
