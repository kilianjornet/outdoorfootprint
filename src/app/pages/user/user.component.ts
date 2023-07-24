import { Component, OnInit, OnDestroy, ViewChild, AfterViewInit } from '@angular/core';
import { MatDialog} from '@angular/material/dialog';
import { AdminService } from '../../services/adminservice.service';
import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';

import Swal from 'sweetalert2'

import {MatPaginator, MatPaginatorModule} from '@angular/material/paginator';
import {MatSort, MatSortModule} from '@angular/material/sort';
import {MatTableDataSource, MatTableModule} from '@angular/material/table';
import {MatInputModule} from '@angular/material/input';
import {MatFormFieldModule} from '@angular/material/form-field';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css'],

})
export class UserComponent implements OnInit {
   //new table ts
   public startLinkindex:number=1;
   public totalrow:any='';
   public term:string='';
   public list:any='';
   public list1:any={};
   public blockresult:any='';
   public unblockresult:any='';
filterdata:any='';
   public totalTodoRecords:number=0;
  public startLinkIndex:number=1;
  searchedtext:any;
  public userList:Array<any>=[];
  displayedColumns: string[] = ['id','image','firstName',  'email','phoneNumber','block','address','action'];
  dataSource:any ;

  @ViewChild(MatPaginator) paginator !: MatPaginator 


  @ViewChild(MatSort, {static: true}) sort!: MatSort;
  searchresult: any;
profile:any='';
  filteredList: any;
  constructor(
    public adminservice: AdminService,
    private dialog:MatDialog,
    private router:Router,
    private spinnerService: NgxSpinnerService
    ) {
  }
  ngOnInit(){
    this.getuser();
 
  }

  onBlock(element: any) {
    Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, block it!'
    }).then((result) => {
      if (result.isConfirmed) {
        try {
          this.adminservice.userBlock(element.id, {}).subscribe((result: any) => {
            this.blockresult = result;
            // console.log("The user's block id is", this.blockresult);
            setTimeout(() => {
              Swal.fire(
                'User has been Blocked.',
                "",
                'success'
              ).then((swalResult) => {
                if (swalResult.isConfirmed) {
                  this.getuser();
                }
              });
            }, 10);
          
          });
        } catch (e) {
       
          this.adminservice.notifyError('Something went wrong');
        }
      }
    });
  }
  
  onunBlock(element:any){
    
  
    Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, unblock it!'


    }).then((result) => {
      if (result.isConfirmed) {

        try{
         
          this.adminservice.userUnblock(element.id,{})
          .subscribe((res:any)=>{
            this.unblockresult=res;
            setTimeout(() => {
              Swal.fire(
                'User has been Unblocked.',
                "",
                'success'
              ).then((swalResult) => {
                if (swalResult.isConfirmed) {
                  this.getuser();
                }
              });
            }, 10);
            // console.log("The user's Unblock id is", this.unblockresult)
          })
    
       }catch(e){
             this.adminservice.hideLoader();
            
             this.adminservice.notifyError('Something went wrong');
           }
       

    
      
      }
    })
 
  }

  
  onclear(input:any){
    input.value = '';
    this.getuser();
  }
  getuser(){
    this.spinnerService.show();
    this.adminservice.getuserlist()
    .subscribe((res:any)=>{
      this.spinnerService.hide();
      this.list=res.results;
     this.dataSource=new MatTableDataSource(this.list);
     this.dataSource.paginator=this.paginator;
     this.dataSource.sort=this.sort;
      this.totalTodoRecords=res.results.length;;
    
    })
  }

  searchuser(query:KeyboardEvent){
    if(query){
      const element=query.target as HTMLInputElement;
      this.adminservice.searchuserlist(element.value).subscribe((res:any)=>{
    
       
        if(res.length>5){
          res.length=5;
        }
        this.searchresult=res;
      })
     
    }
    }
    hides(){
      this.searchresult=undefined
    }
    searckclick(val:string){
  
    
    }

    applyFilter(event: Event) {
      const filterValue = (event.target as HTMLInputElement).value;
      this.dataSource.filter = filterValue.trim().toLowerCase();
  
      if (this.dataSource.paginator) {
        this.dataSource.paginator.firstPage();
      }

    }
  
    search(){
      if(this.searchedtext == ""){
        this.getuser();
    
   
      }else{
        
        this.list=this.list.filter((res:any)=>{
          return JSON.stringify(res).toLowerCase().match(this.searchedtext.toLowerCase());
       
        })
         return   this.totalTodoRecords=this.list.length;
       
      }
 
    }
    handlePageChange(e :any){
      // this.page = e;

      this.startLinkIndex = e;
    }
key="firstName"
reverse:boolean=false;
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
