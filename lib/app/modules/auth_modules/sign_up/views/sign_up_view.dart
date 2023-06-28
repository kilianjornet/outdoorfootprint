import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';
import 'package:my_outdoor_footprint/app/modules/auth_modules/sign_up/widgets/signup_widget.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetManager.authBackground(
        title: StringManager.signUp,
        child: Form(
          key: controller.signUpKey,
          child: Column(
            children: [
              SignUpWidget.nameTextField(
                nameController: controller.firstNameController,
                nameNode: controller.firstNameNode,
                hintText: StringManager.firstName,
                errorText: StringManager.enterValidFirstName,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
              ),
              SignUpWidget.nameTextField(
                nameController: controller.lastNameController,
                nameNode: controller.lastNameNode,
                hintText: StringManager.lastName,
                errorText: StringManager.enterValidLastName,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
              ),
              WidgetManager.emailTextField(
                emailController: controller.emailController,
                emailNode: controller.emailNode,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
              ),
              SignUpWidget.countryTextField(
                countryController: controller.countryController,
                countryNode: controller.countryNode,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
                onTap: () async {
                  final code = await controller.countryPicker.showPicker(
                    context: Get.context!,
                    backgroundColor: ColorManager.primary,
                  );
                  if (code != null) {
                    controller.countryController.text = code.name;
                    controller.country.value = code.name;
                  }
                },
              ),
              SignUpWidget.numberTextField(
                numberController: controller.numberController,
                numberNode: controller.numberNode,
                onChanged: (value) async {},
              ),
              WidgetManager.passwordTextField(
                passwordController: controller.passwordController,
                passwordNode: controller.passwordNode,
                hintText: StringManager.userPassword,
                obscureText: controller.obscurePasswordText,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
              ),
              SignUpWidget.confirmPasswordTextField(
                passwordController: controller.passwordController,
                confirmPasswordController: controller.confirmPasswordController,
                confirmPasswordNode: controller.confirmPasswordNode,
                hintText: StringManager.confirmPassword,
                errorText: StringManager.passwordMismatch,
                onChanged: (value) async {
                  controller.updateButtonState(value);
                },
                obscureText: controller.obscureConfirmPasswordText,
              ),
              SignUpWidget.agreeTermsAndPrivacy(
                isChecked: controller.isChecked,
              ),
              WidgetManager.primaryButton(
                buttonName: StringManager.continueButton,
                isEnable: controller.isEnable,
                onTap: () async {},
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: 30.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${StringManager.haveAccount}? ',
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: ColorManager.subtitleText,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: Text(
                        StringManager.signIn,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          color: ColorManager.titleText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
