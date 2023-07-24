import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';

import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';

import { NgxSpinnerService } from "ngx-spinner";
import { BehaviorSubject, Subject } from 'rxjs';


import { ToastrService } from 'ngx-toastr';
import { environment } from '../../environments/environment';
import { Router } from '@angular/router';
import { JwtHelperService } from '@auth0/angular-jwt';

enum RequestMethod {
  Get = 'get',
  Post = 'post',
  Put = 'put',
  Patch = 'patch',
  Delete = 'delete'
}

@Injectable()
export class AdminService {
  private profileDataSubject = new BehaviorSubject<any>(null);
  profileData$ = this.profileDataSubject.asObservable();

  public api = environment.url;
  public admin_uri = 'auth/';
  public logintoken: any =  localStorage.getItem('token');
  public role = '';
  public userdata: BehaviorSubject<any> = new BehaviorSubject<any>(null);

  public notificationSignal: BehaviorSubject<number> = new BehaviorSubject<number>(0);
  public chatHistorySignal: BehaviorSubject<any> = new BehaviorSubject<any>({});
  public currentChatUserSignal: BehaviorSubject<string> = new BehaviorSubject<string>('');
  public chatHistoryPageSignal: Subject<boolean> = new Subject<boolean>();
  public getaccessTokenExpiration: any = '';
  public getrefreshTokenExpiration: any = '';
  public accessToken: any = '';
  public refreshToken: any = '';

  constructor(
    private router: Router,
    private http: HttpClient,
    private snackBar: MatSnackBar,
    private toaster: ToastrService,
    private loader: NgxSpinnerService,
    private dialog: MatDialog,
    private jwtHelper: JwtHelperService,
    
  ) {
    if (this.logintoken) {
      try { this.role = atob(JSON.parse(atob(this.logintoken.split('.')[1])).sub2) } catch (e) { }

    }

    const profileDataString = localStorage.getItem('profileData');
    if (profileDataString) {
      const profileData = JSON.parse(profileDataString);
      this.profileDataSubject.next(profileData);
    }
  
    
    // Emit the initial profile data
  
  }
  showLoader() {
    this.loader.show()
  }
  hideLoader() {
    this.loader.hide()
  }
  notifySuccess(msg: string) {
    this.toaster.success(msg, 'Success', {
      closeButton: true,
      timeOut: 1600,
      tapToDismiss: true,
    });
  }
  notifyError(msg: string) {
    this.toaster.error(msg, 'Oops', {
      timeOut: 3000,
      closeButton: true,
    });
  }
  getTimeString(date: Date) {
    return date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0') + '-' + date.getDate().toString().padStart(2, '0')
  }
  showToast(msg: string, closeMsg = 'Close', duration = 1000) {
    this.snackBar.open(msg, closeMsg, { duration });
  }
  async callAjax(method: RequestMethod, uri: string, body: any = {}, roleCheck: boolean = true): Promise<any> {
    var headers = new HttpHeaders({
      Authorization: 'Bearer ' + this.logintoken
    });
    let suburi = '';
    if (roleCheck) {
      if (this.role == 'ADMIN') suburi = this.admin_uri;
    }
    return this.http.request(method, this.api + 'api/' + suburi + uri, {
      body,
      headers
    })/*.pipe(map((response: HttpResponse<any>) => response.json()))*/.toPromise()
  }
log(data:any){
  return this.http.post(this.api + 'api/auth/login', data)
}
  async loginService(logindata: any) {
    let response: any = await this.http.post(this.api + 'api/auth/login', { ...logindata }).toPromise()
    // console.log(response);
    if (response.tokens) {


      this.getaccessTokenExpiration = response.tokens.access.expires;
      this.getrefreshTokenExpiration = response.tokens.refresh.expires;
      // this.accessToken=response.tokens.access.token;
      // this.refreshToken=response.tokens.refresh.token
      this.logintoken = response.tokens.access.token;
      this.userdata.next(response.user);
      localStorage.setItem('token', response.tokens.access.token);
      localStorage.setItem('refreshtoken', response.tokens.refresh.token);
    }
    return response;
  }



  isTokenExpired(): boolean {
    const token = localStorage.getItem('token'); // Replace with how you access your token
    // console.log(token);
    return this.jwtHelper.isTokenExpired(token);

  }
  getNewaccessToken() {
    const token = localStorage.getItem('refreshtoken'); // Replace with how you access your token
    const access = localStorage.getItem('token');
    // console.log(token);
    const isRfreshTokenExpire = this.jwtHelper.isTokenExpired(token);
    if (isRfreshTokenExpire) {
      return this.logout();
    }
    const refreshTokenUrl = this.api + 'api/auth/refresh-tokens';
    const refreshTokenPayload = { refreshToken: token };


    this.http.post<any>(refreshTokenUrl, refreshTokenPayload).
      subscribe((response) => {
        // console.log(response.access.token);

        // console.log(response.refresh.token)
        localStorage.setItem('token', response.access.token);
        localStorage.setItem('refreshtoken', response.refresh.token);

      })

  }





  profileUpdate(data: any) {
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/auth/update-profile`, data, { headers });

  }
  getUserLoggedIn() {
    return this.logintoken
  }


  getuserlist() {

    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/users?role=user`, { headers })
  }

  searchuserlist(last: string) {
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}users?lastName${last}&firstName$`, { headers })

  }



  getuser(id: string) {
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/users/${id}`, { headers })
  }



  userupdate(data: any) {
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/auth/update-profile`, data, { headers })
  }



  getcarbonlist() {
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/users/carbon-calulation/get-all-user-calculation`, { headers })
  }


  getcarbonbyid(id: string) {
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/users/get-all-calculation-by-user-id/${id}`, { headers })
  }

  getCms(){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/cms`, { headers })
  }
  getCmsByid(id:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/cms/${id}`, { headers })
  }
  cmsUpdate(id:any,data: any,) {
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/cms/update/${id}`, data, { headers })
  }
  forgotPass(data:any){
   
    return this.http.post(`${this.api}api/auth/forgot-password`, data)
  
  }
  verifypass(data:any){
    return this.http.post(`${this.api}api/auth/verify-forgot-password`, data)
    
  }
  resetPass(data:any){
    
    return this.http.post(`${this.api}api/auth/reset-password`, data);
  }



  cmsimageUploadByid(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/cms/upload-cms-image/${id}`,data, { headers })
  }
  cmsimagedeleteByid(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/cms/remove-cms-image/${id}`,data, { headers })
  }


  userBlock(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/auth/block-user/${id}`,data,{ headers });
    
  }

  userUnblock(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/auth/unblock-user/${id}`,data,{ headers });
  }
  updateProfileData(profileData: any) {
     // Update the profile data in localStorage
     localStorage.setItem('profileData', JSON.stringify(profileData));
    
     // Emit the updated profile data
     this.profileDataSubject.next(profileData);
  }
  getTips(){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
  
    return this.http.get(`${this.api}api/tips`,{headers})
  }
  getTipsId(id:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
  
    return this.http.get(`${this.api}api/tips/${id}`,{headers})
  }

  tipsupdatebyid(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
  
    return this.http.post(`${this.api}api/tips/update/${id}`,data, {headers})
  }
  tipstitlebyid(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });

    return this.http.post(`${this.api}api/tips/update/tips-title/${id}`,data, {headers})
  }
  yearCo2id(id:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
  
  
    return this.http.get(`${this.api}api/users/get-all-calculation-four-year-by-user-id/${id}`, {headers})
  }


  getnotification(){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/fcm/get-all-notification`, { headers })
  }


  getOffset(){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/offset/`, { headers })
  }
  getOffsetId(id:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.get(`${this.api}api/offset/${id}`, { headers })
  }


  updateOffsetID(id:any,data:any){
const tokenss=this.isTokenExpired();
if(tokenss){
  this.getNewaccessToken()

}
const token = localStorage.getItem('token');
const headers = new HttpHeaders({
  Authorization: 'Bearer ' + token
});
return this.http.post(`${this.api}api/offset/update/${id}`,data, { headers })

  }
  sendNotification(data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/fcm/send-notification-all-users`, data, { headers });


  }



addCms(data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/cms/add/new-cms`, data, { headers });


  }

  addOffset(data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/offset/add/new-offset`, data, { headers });


  }

  addTips(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/tips/add/new-tips/${id}`, data, { headers });


  }
  deleteTips(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/tips/remove/tips-content/${id}`, data, { headers });


  }
  deletecms(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/cms/remove/cms-data/${id}`, data, { headers });


  }

  offsetDelete(id:any,data:any){
    const tokenss = this.isTokenExpired();
    // console.log(tokenss);
    if (tokenss) {
      this.getNewaccessToken()

    }
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: 'Bearer ' + token
    });
    return this.http.post(`${this.api}api/offset/remove/offset-data/${id}`, data, { headers });
  }

 logout() {
    localStorage.clear();
    this.logintoken = '';
    this.userdata.next(null);
    this.router.navigateByUrl('/login')
      .then(() => { window.location.reload(); })
  }

}


