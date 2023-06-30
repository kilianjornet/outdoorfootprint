import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WidgetManager.authBackground(
        title: StringManager.resetPasswordTitle,
        child: Form(
          key: controller.resetPasswordKey,
          child: Column(
            children: [
              WidgetManager.passwordTextField(
                passwordController: controller.passwordController,
                passwordNode: controller.passwordNode,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
                obscureText: controller.obscurePasswordText,
              ),
              WidgetManager.confirmPasswordTextField(
                passwordController: controller.passwordController,
                confirmPasswordController: controller.confirmPasswordController,
                confirmPasswordNode: controller.confirmPasswordNode,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
                obscureText: controller.obscureConfirmPasswordText,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 25.h,
                ),
                child: WidgetManager.primaryButton(
                  buttonName: StringManager.submit,
                  isEnable: controller.isEnable,
                  onTap: () async {},
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
