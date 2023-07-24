import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginauthGuard implements CanActivate {

    authlog: any
    constructor(private router: Router) { }
    canActivate(route: ActivatedRouteSnapshot) {
      this.authlog = localStorage.getItem('token')
      if (this.authlog == null) {
        return true;
      } else {
        this.router.navigate(['main/dashboard']);
        return false;
      }
    }
  
}
