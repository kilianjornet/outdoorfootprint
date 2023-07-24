import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);
import { ChartDataset, ChartOptions, ChartType } from 'chart.js';
import { NgxSpinnerService } from 'ngx-spinner';
import { AdminService } from 'src/app/services/adminservice.service';
import { AgChartOptions } from 'ag-charts-community';
import { MatTabsModule } from '@angular/material/tabs';
@Component({
  selector: 'app-calculator',
  templateUrl: './calculator.component.html',
  styleUrls: ['./calculator.component.css']
})
export class CalculatorComponent implements OnInit {
  public options: any;
 public value:number=90;
 public id:any='';
 public carbonrecord:any='';
 home:any=5500;
 public home1:any='';
 dataof2020:any='';
 dataof2021:any='';
 dataof2022:any='';
 dataof2023:any='';
 year1:any='';
 year2:any='';
 year3:any='';
 year4:any='';
 constructor(  public adminservice: AdminService,private route: ActivatedRoute ,   private spinnerService: NgxSpinnerService){


 }
 ngOnInit(): void {
  this.id=this.route.snapshot.paramMap.get('id');
  this.getCarbonById();

  this.getyeardata()

 }
 

 getCarbonById(){
  this.spinnerService.show();
  this.adminservice.getcarbonbyid(this.id)
  .subscribe((res:any)=>{
    this.spinnerService.hide();
    
    this.carbonrecord=res.allCalculationByUserId;
    this.dougnutchart(this.carbonrecord);
    this.processChartData(this.carbonrecord);
  
    //  console.log(this.home)
 
  
  })
}
processChartData(data: any) {
  const series = [
    {
      type: 'pie',
      calloutLabelKey: 'os',
      angleKey: 'share',
      innerRadiusOffset: -70,
    },
  ];

  this.options = {
    data:  [
      { os: 'Android', share: data.totalHomeCo2},
      { os: 'iOS', share: data.totalMobilityCo2 },
      { os: 'BlackBerry', share: data.totalGearCo2},
      { os: 'Symbian', share:data.totalOtherCo2 },
      { os: 'Bada', share: 2.6 },
      { os: 'Windows', share: 1.9 },
    ],
    series: series,
  };
}
dougnutchart(data:any){

  var myChart = new Chart("myChart", {
    type: 'doughnut',
    data: {
        labels: ['Home', 'Mobility', 'Gear', 'Food & Others', 'Public service share'],
        datasets: [{
            label: '# of Votes',
            data: [data.totalHomeCo2, data.totalMobilityCo2, data.totalGearCo2,data.totalOtherCo2,data.totalPublicShareCo2],
            backgroundColor: [
              'rgb(255, 99, 132)',
              'rgb(54, 162, 235)',
              'rgb(255, 205, 86)',
                'rgba(75, 192, 192, 0.4)',
                'rgba(153, 102, 255, 0.4)',
          
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
           
            ],
            borderWidth: 1,
            hoverOffset: 4,
        }]
    },
    options: {
       
    }
  });
}
// bar chart 

public barChartLabels:any = [ ];

public barChartType = 'horizontalBar';

public barChartLegend = true;
public barChartData1:any = [];


public barChartOptions = {
  responsive: true,
  scales: {
    x: {
      beginAtZero: true,
    },
    y: {
      beginAtZero: true,
    },
  },
};

getyeardata(){
  this.adminservice.showLoader();
  try{
this.adminservice.yearCo2id(this.id)
.subscribe((res:any)=>{
  this.adminservice.hideLoader();
  
 this.year4=res.fourYearData[0].year;
 this.year3=res.fourYearData[1].year;
 this.year2=res.fourYearData[2].year;
 this.year1=res.fourYearData[3].year;

  this.dataof2023=res.fourYearData[0].calculation;
  this.dataof2022=res.fourYearData[1].calculation;
  this.dataof2021=res.fourYearData[2].calculation;
  this.dataof2020=res.fourYearData[3].calculation;
 
this.barChartLabels=[this.year1,this.year2,this.year3,this.year4]

  this.barChartData1= [
    { data: [
   this.dataof2020.totalKgCo2OfHome, this.dataof2021.totalKgCo2OfHome, this.dataof2022.totalKgCo2OfHome, this.dataof2023.totalKgCo2OfHome],
    label: 'Home',backgroundColor: [
      'rgb(255, 99, 132)', ] },

    { data: [ this.dataof2020.totalKgCo2OfMobility,this.dataof2021.totalKgCo2OfMobility, this.dataof2022.totalKgCo2OfMobility, this.dataof2023.totalKgCo2OfMobility],
       label: 'Mobility',backgroundColor: [
      'rgb(54, 162, 235)', ] },

    { data: [ this.dataof2020.totalKgCo2OfGear,this.dataof2021.totalKgCo2OfGear, this.dataof2022.totalKgCo2OfGear,this.dataof2023.totalKgCo2OfGear],
       label: 'Gear',backgroundColor: [
      'rgb(255, 205, 86)', ] },

    { data: [ this.dataof2020.totalKgCo2OfOthers,this.dataof2021.totalKgCo2OfOthers, this.dataof2022.totalKgCo2OfOthers, this.dataof2023.totalKgCo2OfOthers],
       label: 'Food & Others',backgroundColor: [
      'rgba(57, 250, 234,0.4)', ] },
    { data: [ this.dataof2020.totalKgCo2OfPublicServiceShare,this.dataof2021.totalKgCo2OfPublicServiceShare, this.dataof2022.totalKgCo2OfPublicServiceShare, this.dataof2023.totalKgCo2OfPublicServiceShare],
       label: 'Public service share',backgroundColor: [
      'rgba(153, 102, 255, 0.4)', ] }
  ];




})
  }catch(e){
    this.adminservice.hideLoader();
    this.adminservice.notifyError('something went wrong')
  }
}

}
