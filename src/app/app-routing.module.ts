import { Component, NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './pages/login/login.component';
import { ForgotpasswordComponent } from './pages/forgotpassword/forgotpassword.component';
import { VpassComponent } from './pages/vpass/vpass.component';
import { MainComponent } from './pages/main/main.component';
import { UpdateProfileComponent } from './pages/update-profile/update-profile.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { ChangepasswordComponent } from './pages/changepassword/changepassword.component';
import { CalculatorComponent } from './pages/calculator/calculator.component';
import { CarbonmanagementComponent } from './pages/carbonmanagement/carbonmanagement.component';
import { UserComponent } from './pages/user/user.component';
import { EdituserComponent } from './pages/edituser/edituser.component';
import { ViewUserComponent } from './pages/view-user/view-user.component';
import { CmsListComponent } from './pages/cms-list/cms-list.component';
import { CmsEditComponent } from './pages/cms-edit/cms-edit.component';
import { LoginauthGuard } from './loginauth.guard';
import { AuthGuard } from './auth.guard';
import { NewpassComponent } from './pages/newpass/newpass.component';
import { ImageComponent } from './pages/image/image.component';
import { TipsComponent } from './pages/tips/tips.component';
import { TpiseditComponent } from './pages/tpisedit/tpisedit.component';
import { PNotificationComponent } from './pages/p-notification/p-notification.component';
import { NotificationHistoryComponent } from './pages/notification-history/notification-history.component';
import { OfsetComponent } from './pages/ofset/ofset.component';
import { OffseteditComponent } from './pages/offsetedit/offsetedit.component';
import { DialogtipsComponent } from './pages/dialogtips/dialogtips.component';
import { DialogoffsetComponent } from './pages/dialogoffset/dialogoffset.component';
import { DialogcmsComponent } from './pages/dialogcms/dialogcms.component';


const routes: Routes = [ { path: '', redirectTo: 'login', pathMatch: 'full' },
{ path: 'login', component: LoginComponent,canActivate:[LoginauthGuard]   },
{path:'forgotpassword', component:ForgotpasswordComponent,},
{path:'vpass/:email', component:VpassComponent, },
{path:'newpass/:token', component:NewpassComponent},
{
  path: 'main', component: MainComponent, canActivate:[AuthGuard],
  children: [
    { path: 'dashboard', component: DashboardComponent },
    { path: 'profile', component: UpdateProfileComponent },
    { path: 'change-password', component: ChangepasswordComponent },
   
    {path:'carbonmanagement/calculator/:id',component:CalculatorComponent},
    {path:'carbonmanagement',component:CarbonmanagementComponent},
    {
      path: 'users', component: UserComponent
    },
    //{ path: 'users/:id', component: ViewUserComponent },
    {
      path: 'users/edituser/:id', component: EdituserComponent
    },
    { path: 'interpreters/:id', component: ViewUserComponent },
    /////////////
 {path:'cms/edit/image/:id', component:ImageComponent},

    { path: 'cms', component: CmsListComponent },
    {path:'cmsdialog',component:DialogcmsComponent},
    {path:'offset', component:OfsetComponent},
    {path:'offset/offsetedit/:id',component:OffseteditComponent},
    {path:'offsetdialog',component:DialogoffsetComponent},
    {
      path: 'cms/edit/:id',
component:CmsEditComponent
      // loadChildren: './pages/edit-cms/edit-cms.module#EditCmsModule'//for prod build
    },
{path:'tips', component:TipsComponent},
{path:'tips/tipsedit/:id', component:TpiseditComponent},
{path:'tipsdialog', component:DialogtipsComponent},
{path:'notification',component:PNotificationComponent},
{path:'nhistory', component:NotificationHistoryComponent},

 
    /*{ path: 'community', loadChildren : './pages/community/community.module#CommunityModule', }*/
  ]
},];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
