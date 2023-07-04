import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

import '../controllers/send_email_controller.dart';

class SendEmailView extends GetView<SendEmailController> {
  const SendEmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WidgetManager.authBackground(
        title: StringManager.forgetPassword,
        child: Form(
          key: controller.sendEmailKey,
          child: Column(
            children: [
              WidgetManager.emailTextField(
                emailController: controller.emailController,
                emailNode: controller.emailNode,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 25.h,
                ),
                child: WidgetManager.primaryButton(
                  buttonName: StringManager.submit,
                  isEnable: controller.isEnable,
                  onTap: () async {
                    Get.toNamed('/verify-otp');
                  },
                ),
              ),
              WidgetManager.backToSignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
