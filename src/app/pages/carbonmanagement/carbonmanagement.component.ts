import { Component, OnInit, OnDestroy, ViewChild } from '@angular/core';
import { MatDialog} from '@angular/material/dialog';
import { AdminService } from '../../services/adminservice.service';
// import { InfiniteTableHandler, InfiniteTableCellFilters, InfiniteTableSettings } from '../../components/infinite-table/infinite-table.component';
// import { YesNoDialogComponent } from '../../components/yes-no-dialog/yes-no-dialog.component';
import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';
import {MatPaginator, MatPaginatorModule} from '@angular/material/paginator';
import {MatSort, MatSortModule} from '@angular/material/sort';
import {MatTableDataSource, MatTableModule} from '@angular/material/table';
import {MatInputModule} from '@angular/material/input';
import {MatFormFieldModule} from '@angular/material/form-field';
@Component({
  selector: 'app-carbonmanagement',
  templateUrl: './carbonmanagement.component.html',
  styleUrls: ['./carbonmanagement.component.css']
})
export class CarbonmanagementComponent {


   //new table ts
   public startLinkindex:number=1;
   public totalrow:any='';
   public term:string='';
   public list:any='';
   public list1:any={};

   public totalTodoRecords:number=0;
  public startLinkIndex:number=1;
  searchedtext:any;
  public userList:Array<any>=[];

  searchresult: any;
  displayedColumns: string[] = ['id','name','home',  'mobility','gear','food','public','kg','action'];
  dataSource:any ;
  

  @ViewChild(MatPaginator) paginator !: MatPaginator 
  @ViewChild(MatSort) sort!:MatSort 
  constructor(
    public adminservice: AdminService,
    private dialog:MatDialog,
    private router:Router,
    private spinnerService: NgxSpinnerService
    ) {
  }
  ngOnInit(){
    this.getCarbon();
  }
  ngOnDestroy(){
  }
  onclear(input:any){
    input.value = '';
    this.getCarbon();
  }
  getCarbon(){
    this.spinnerService.show();
    this.adminservice.getcarbonlist()
    .subscribe((res:any)=>{
      this.spinnerService.hide();
      this.list=res.allUserCalculation;
      this.dataSource=new MatTableDataSource(this.list);
      this.dataSource.paginator=this.paginator;
      this.dataSource.sort=this.sort;
      this.totalTodoRecords=res.allUserCalculation.length;;
   
    })
  }
  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
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
    viewpage(element:any){
      this.router.navigate(['/main/carbonmanagement/calculator',element.userId])
    }
    search(){
      if(this.searchedtext == ""){
        this.getCarbon();
        this.totalTodoRecords=this.list.length;
      }else{
        this.list=this.list.filter((res:any)=>{
          return JSON.stringify(res).toLowerCase().match(this.searchedtext.toLowerCase());
       
        })
      }
      return   this.totalTodoRecords=this.list.length;
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
