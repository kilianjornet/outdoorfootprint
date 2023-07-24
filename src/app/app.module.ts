import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';




import {NgxPaginationModule} from 'ngx-pagination';

// Import ng-circle-progress
import { NgCircleProgressModule } from 'ng-circle-progress';
import { NgChartsModule } from 'ng2-charts';
import { CanvasJSAngularChartsModule } from '@canvasjs/angular-charts';
import { NgxApexchartsModule } from 'ngx-apexcharts';
import { MatPaginatorModule } from '@angular/material/paginator';

import { AvatarModule } from 'ngx-avatars';
// import * as CanvasJSAngularChart from '../assets/canvasjs.angular.component';
// var CanvasJSChart = CanvasJSAngularChart.CanvasJSChart;


import { NgOtpInputModule } from  'ng-otp-input';
import { HttpClientModule } from '@angular/common/http';
import { ToastrModule } from 'ngx-toastr';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MAT_DATE_FORMATS } from '@angular/material/core';
import { MatInputModule } from '@angular/material/input';
import { MatChipsModule } from '@angular/material/chips';
import { MatBadgeModule } from '@angular/material/badge';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatRadioModule } from '@angular/material/radio';


import { NgxSpinnerModule } from "ngx-spinner";


import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';

import { MatSidenavModule } from '@angular/material/sidenav';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatListModule } from '@angular/material/list';
import { MatMenuModule } from '@angular/material/menu';
import { MatIconModule } from '@angular/material/icon';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';




import { MatTableModule } from '@angular/material/table';
import { MatDialogModule } from '@angular/material/dialog';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';



import { MatSliderModule } from '@angular/material/slider';
import { MatSelectModule } from '@angular/material/select';






import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { VpassComponent } from './pages/vpass/vpass.component';
import { ViewUserComponent } from './pages/view-user/view-user.component';
import { UserComponent } from './pages/user/user.component';
import { UpdateProfileComponent } from './pages/update-profile/update-profile.component';
import { MainComponent } from './pages/main/main.component';
import { LoginComponent } from './pages/login/login.component';
import { ForgotpasswordComponent } from './pages/forgotpassword/forgotpassword.component';
import { EdituserComponent } from './pages/edituser/edituser.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { CmsListComponent } from './pages/cms-list/cms-list.component';
import { CmsEditComponent } from './pages/cms-edit/cms-edit.component';
import { ChangepasswordComponent } from './pages/changepassword/changepassword.component';
import { CarbonmanagementComponent } from './pages/carbonmanagement/carbonmanagement.component';
import { CalculatorComponent } from './pages/calculator/calculator.component';
import { AngularEditorModule } from '@kolkov/angular-editor';
import { JwtModule } from '@auth0/angular-jwt';
import { AdminService } from './services/adminservice.service';
import { HashLocationStrategy, LocationStrategy } from '@angular/common';
import {AgChartsAngularModule} from 'ag-charts-angular';
import { NewpassComponent } from './pages/newpass/newpass.component';
import { CKEditorModule } from 'ckeditor4-angular';
import { ImageComponent } from './pages/image/image.component';
import { TipsComponent } from './pages/tips/tips.component';
import { TpiseditComponent } from './pages/tpisedit/tpisedit.component';
import { PNotificationComponent } from './pages/p-notification/p-notification.component';
import { NotificationHistoryComponent } from './pages/notification-history/notification-history.component';
import { MatTabsModule } from '@angular/material/tabs';
import { OfsetComponent } from './pages/ofset/ofset.component';
import { OffseteditComponent } from './pages/offsetedit/offsetedit.component';
import { DialogtipsComponent } from './pages/dialogtips/dialogtips.component';
import { DialogcmsComponent } from './pages/dialogcms/dialogcms.component';
import { DialogoffsetComponent } from './pages/dialogoffset/dialogoffset.component'; 
export function tokenGetter() {
  return localStorage.getItem("token");
}
@NgModule({
  declarations: [
    AppComponent,
    VpassComponent,
    ViewUserComponent,
    UserComponent,
    UpdateProfileComponent,
    MainComponent,
    LoginComponent,
    ForgotpasswordComponent,
    EdituserComponent,
    DashboardComponent,
    CmsListComponent,
    CmsEditComponent,
    ChangepasswordComponent,
    CarbonmanagementComponent,
    CalculatorComponent,
    
    NewpassComponent,
    ImageComponent,
    TipsComponent,
    TpiseditComponent,
    PNotificationComponent,
    NotificationHistoryComponent,
    OfsetComponent,
    OffseteditComponent,
    DialogtipsComponent,
    DialogcmsComponent,
    DialogoffsetComponent,
    // CanvasJSChart
   
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
 BrowserAnimationsModule,
    // Ng5SliderModule,
    MatCheckboxModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatCardModule,
    MatSidenavModule,
    MatToolbarModule,
    MatListModule,
    MatMenuModule,
    MatIconModule,
    MatTabsModule,
    MatSnackBarModule,
    MatChipsModule,
    FormsModule,
    MatDialogModule,
    ReactiveFormsModule,
    MatSliderModule,
    MatSelectModule,
    HttpClientModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatBadgeModule,
MatPaginatorModule,
    MatExpansionModule,
    MatRadioModule,
MatTableModule,
    NgxPaginationModule,

    ToastrModule.forRoot(),
    // Ng4LoadingSpinnerModule.forRoot(),
    NgxSpinnerModule,
    CKEditorModule,

      // Specify ng-circle-progress as an import
      NgCircleProgressModule.forRoot({
        // set defaults here
        radius: 100,
        outerStrokeWidth: 16,
        innerStrokeWidth: 8,
        outerStrokeColor: "#78C000",
        innerStrokeColor: "#C7E596",
        animationDuration: 300,
      
      }),
      NgChartsModule,
      CanvasJSAngularChartsModule,
      NgxApexchartsModule,
      JwtModule.forRoot({
        config: {
          tokenGetter: function  tokenGetter() { 
          return localStorage.getItem('token');
          } 
       }
     }),
      AvatarModule,
      NgOtpInputModule,
      AngularEditorModule,
      AgChartsAngularModule
  ],
  providers: [
    AdminService,
    MatDatepickerModule,
  
   
    { provide: MAT_DATE_FORMATS, useValue: MAT_DATE_FORMATS },
    { provide: LocationStrategy, useClass: HashLocationStrategy },
    
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }


