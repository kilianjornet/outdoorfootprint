import { Component, Inject } from '@angular/core';
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
  selector: 'app-dialogoffset',
  templateUrl: './dialogoffset.component.html',
  styleUrls: ['./dialogoffset.component.css']
})
export class DialogoffsetComponent {

  editorConfig: AngularEditorConfig = {
    editable: true,
    uploadUrl: this.adminService.api+'api/cms/update/'
  };
  form: FormGroup;

  constructor(
    private dialogRef: MatDialogRef<DialogoffsetComponent>,
    @Inject(MAT_DIALOG_DATA) private data: any,
    private fb: FormBuilder,private adminService:AdminService,
  ) {
    // Create the form with the necessary form controls and validators
    this.form = this.fb.group({
      text: ['', [Validators.required, RichTextRequiredValidator]],
      title:[''],
      amount:[''],
      url:[''],
      name: ['', [Validators.required, Validators.pattern('^[a-z]+$')]],
    });
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
  "content": this.form.value['text'],
  "amount": this.form.value['amount'].toString(),
  "url":this.form.value['url'],
}
try{
  this.adminService.addOffset(payload)
  .subscribe((res:any)=>{
  
    this.adminService.notifySuccess(res.message)
  })

}catch(e){
this.adminService.notifyError("something send wrong")
}
     

      this.dialogRef.close(this.form.value);
    }
  }
}
