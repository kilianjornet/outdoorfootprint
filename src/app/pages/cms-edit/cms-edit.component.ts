import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../services/adminservice.service';
import { ActivatedRoute, Router } from '@angular/router';
import { AngularEditorConfig } from '@kolkov/angular-editor';
import { hasText } from 'html-text-content';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';

function RichTextRequiredValidator(control: FormControl) {
  let div=document.createElement('div');
  div.innerHTML=control.value;
  if(!hasText(div))
    return {
      content: 'Content is required'
    }
  return null;
}
@Component({
  selector: 'app-cms-edit',
  templateUrl: './cms-edit.component.html',
  styleUrls: ['./cms-edit.component.css'],
})
export class CmsEditComponent implements OnInit {
  cmsId:any='';
  cmsContent:any='';
  pagename:string='...';
  editorConfig: AngularEditorConfig = {
    editable: true,
    uploadUrl: this.adminService.api+'api/cms/update/'
  };
  formGroup!:FormGroup;
  plainText=false;

  constructor(private adminService:AdminService,
    private route: ActivatedRoute, private fb:FormBuilder, private router:Router) {
      this.cmsId=this.route.snapshot.paramMap.get('id');
      this.editorConfig.uploadUrl+=this.cmsId;
     
  }


  ngOnInit() {
    this.formGroup=this.fb.group({
      text: ['', [Validators.required, RichTextRequiredValidator]],
      title:[''],
    })
    // this.loadData();
    this.getCmsbyId();
 
  }

  sendImage() {
    const formData = this.formGroup.value;
    // Handle sending the image data

  }

 
  onGalary(){
    this.router.navigate(['/main/cms/edit/image',this.cmsId])
  }
getCmsbyId(){
  this.adminService.showLoader();
  try{
   this.adminService.getCmsByid(this.cmsId)
   .subscribe((response:any)=>{
    this.adminService.hideLoader();
    if(response.status){
      // this.adminService.notifySuccess(response.message);
   
      this.formGroup.patchValue({text: response.cms.content})
      this.formGroup.patchValue({title: response.cms.title})
      //this.cmsContent=;
      this.pagename=response.cms.title;
      this.plainText=(response.cms.name.startsWith('welcome-message'));
    }else{
      this.adminService.notifyError(response.message);
    }
   })
 
   
  }catch(e){
    this.adminService.hideLoader();

    this.adminService.notifyError('Internal Server Error');
  }
}


 
  savecms(){
     this.adminService.showLoader();
     try{
     const payload={
      "content":this.formGroup.value['text'],
      "title":this.formGroup.value['title']
     }
     this.adminService.cmsUpdate(this.cmsId,payload).subscribe
     ((response:any)=>{
      this.adminService.hideLoader();
      if(response.status){
        this.adminService.notifySuccess(response.message);
     
      }else{
        this.adminService.notifyError(response.message);
      }
     })
     
    }catch(e){
      this.adminService.hideLoader();

      this.adminService.notifyError("Internal server error");
    }
  }
}
