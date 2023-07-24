import { Component, OnInit, Renderer2 } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AdminService } from 'src/app/services/adminservice.service';

@Component({
  selector: 'app-image',
  templateUrl: './image.component.html',
  styleUrls: ['./image.component.css']
})
export class ImageComponent implements OnInit {
id:any='';
image:any='';
selectfile:any='';
headname:any='';
constructor(    private route: ActivatedRoute, public adminservice:AdminService,
  private renderer: Renderer2, private router:Router){

}
ngOnInit(): void {
  this.route.paramMap.subscribe((params) => {
    this.id = params.get('id');
  
    
  });
  this.getimage();
}
image1(event: any) {

  this.selectfile = event.target.files[0];



  const formData = new FormData();
  formData.append('images', this.selectfile);
this.adminservice.cmsimageUploadByid(this.id,formData).subscribe((res:any)=>{

  this.adminservice.notifySuccess(res.message);
  this.getimage();
})

}
delete(image:any){

const fdata=new FormData;

const payload={
  "image_path":image
}
this.adminservice.cmsimagedeleteByid(this.id,payload)
.subscribe((res:any)=>{

  this.adminservice.notifySuccess(res.message)
  this.getimage();
})
} 

getimage(){
  this.adminservice.showLoader();
     try{
     this.adminservice.getCmsByid(this.id).subscribe((res:any)=>{
      this.adminservice.hideLoader();

if(res.status){
this.image=res.cms.images;
this.headname=res.cms.title;

}else{
  this.adminservice.notifyError('Something went wrong');
}
})
}catch(e){
      this.adminservice.hideLoader();
  
      this.adminservice.notifyError('Something went wrong');
    }
}
copyImagePath(path: string) {
  const tempInput = this.renderer.createElement('input');
  this.renderer.setAttribute(tempInput, 'value', path);
  this.renderer.appendChild(document.body, tempInput);
  tempInput.select();
  tempInput.copied = true;
  document.execCommand('copy');
  this.adminservice.showToast('Path Copied')
  this.renderer.removeChild(document.body, tempInput);
}

onBack(){
  this.router.navigateByUrl('/main/cms/edit/'+this.id)
}

}
