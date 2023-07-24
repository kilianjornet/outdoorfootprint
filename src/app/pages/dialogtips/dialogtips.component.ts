import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators,FormControl } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { hasText } from 'html-text-content';
import { AngularEditorConfig } from '@kolkov/angular-editor';
import { AdminService } from '../../services/adminservice.service';
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
  selector: 'app-dialogtips',
  templateUrl: './dialogtips.component.html',
  styleUrls: ['./dialogtips.component.css']
})
export class DialogtipsComponent implements OnInit{
  editorConfig: AngularEditorConfig = {
    editable: true,
    uploadUrl: this.adminService.api+'api/cms/update/'
  };
  form: FormGroup;
  id: any;

  constructor(
    private dialogRef: MatDialogRef<DialogtipsComponent>,
    @Inject(MAT_DIALOG_DATA) private data: any,
    private fb: FormBuilder,private adminService:AdminService,
  ) {
    // Create the form with the necessary form controls and validators
    this.form = this.fb.group({
      name: ['', [Validators.required, Validators.pattern('^[a-z]+$')]],
      title: ['', [Validators.required]],
      text: ['', [Validators.required, RichTextRequiredValidator]],
    });
  }
ngOnInit(): void {
  this.gettips();
}
  onCancel(): void {
    this.dialogRef.close();
  }

  onSubmit(): void {
    if (this.form.valid) {
      // You can access the form values using this.form.value
      const payload={
        
          "name": this.form.value['name'],
          "title": this.form.value['title'],
          "content": this.form.value['text']
  
      }
      try{
        this.adminService.addTips(this.id,payload)
        .subscribe((res:any)=>{
        
          this.adminService.notifySuccess(res.message)
        })
      
      }catch(e){
      this.adminService.notifyError("something send wrong")
      }
      this.dialogRef.close(this.form.value);
    }
  }
  gettips(){
    this.adminService.showLoader();

this.adminService.getTips()
.subscribe((response:any)=>{
this.adminService.hideLoader();


  this.id=response.allTips[0].id;


 

})
    } 
  

}
