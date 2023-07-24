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
  selector: 'app-tpisedit',
  templateUrl: './tpisedit.component.html',
  styleUrls: ['./tpisedit.component.css']
})
export class TpiseditComponent implements OnInit {
  tipsId:any='';
  cmsContent1:any='';
  pagename:string='...';
  editorConfig: AngularEditorConfig = {
    editable: true,
    uploadUrl: this.adminService.api+'api/cms/update/'
  };
  formGroup!:FormGroup;
  plainText=false;

  constructor(private adminService:AdminService,
    private route: ActivatedRoute, private fb:FormBuilder, private router:Router) {
      this.tipsId=this.route.snapshot.paramMap.get('id');
      this.editorConfig.uploadUrl+=this.tipsId;
     
  }


  ngOnInit() {
    this.formGroup=this.fb.group({
      text: ['', [Validators.required, RichTextRequiredValidator]],
      title:['']
    })
    // this.loadData();
    this.getTipsbyId();
 
  }

  sendImage() {
    const formData = this.formGroup.value;
    // Handle sending the image data

  }

 
getTipsbyId(){
  this.adminService.showLoader();
  try{
   this.adminService.getTipsId(this.tipsId)
   .subscribe((response:any)=>{
    this.adminService.hideLoader();
    if(response.status){
      // this.adminService.notifySuccess(response.message);
   
      this.formGroup.patchValue({text: response.tips.content[0].content})
      this.formGroup.patchValue({title: response.tips.content[0].content_title})
      this.cmsContent1=response.tips.content[0];
   
      this.pagename=response.tips.tips_title;
      this.plainText=(response.tips.content[0].content_name.startsWith('welcome-message'));
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
      "title":this.formGroup.value['title'],
     }
     this.adminService.tipsupdatebyid(this.tipsId,payload).subscribe
     ((response:any)=>{
      this.getTipsbyId();
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
