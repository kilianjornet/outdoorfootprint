import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AdminService } from './services/adminservice.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  
  constructor(public adminservice: AdminService, private router: Router){

  }
 
  canActivate(next: ActivatedRouteSnapshot,state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
    if(this.adminservice.getUserLoggedIn()){
  
     
     
      return true;

    }
    else{
    
      this.router.navigate(['/']);
      return false;
    }
  }
  
}
