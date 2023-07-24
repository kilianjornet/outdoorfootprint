
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
  selector: 'app-offsetedit',
  templateUrl: './offsetedit.component.html',
  styleUrls: ['./offsetedit.component.css']
})
export class OffseteditComponent implements OnInit {
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
      title:[''],
      amount:[''],
      url:['']
    })
    // this.loadData();
    this.getoffsetbyId();
 
  }

  sendImage() {
    const formData = this.formGroup.value;
    // Handle sending the image data

  }

 
getoffsetbyId(){
  this.adminService.showLoader();
  try{
   this.adminService.getOffsetId(this.tipsId)
   .subscribe((response:any)=>{
    this.adminService.hideLoader();
    if(response.status){
      // this.adminService.notifySuccess(response.message);

      this.formGroup.patchValue({text: response.offset.content})
      this.formGroup.patchValue(response.offset)
      this.cmsContent1=response.offset.content;
   
      this.pagename=response.offset.title;
      // this.plainText=(response.offset.content.name('welcome-message'));
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
      "amount":this.formGroup.value['amount'].toString(),
      "url":this.formGroup.value['url'],


    
     }
     this.adminService.updateOffsetID(this.tipsId,payload).subscribe
     ((response:any)=>{
      this.getoffsetbyId();
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
