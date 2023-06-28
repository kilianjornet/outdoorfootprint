import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/color_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WidgetManager.authBackground(
          child: Form(
        key: controller.signInKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 5.h,
              ),
              child: Text(
                StringManager.signIn,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  color: ColorManager.displayText,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 35.h,
              ),
              child: Text(
                StringManager.greetingText,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: ColorManager.captionText,
                ),
              ),
            ),
            WidgetManager.emailTextField(
              emailController: controller.emailController,
              emailNode: controller.emailNode,
              onChanged: (value) async {
                controller.updateButtonState(value);
              },
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
            Padding(
              padding: EdgeInsets.only(
                top: 30.h,
                bottom: 25.h,
              ),
              child: GestureDetector(
                onTap: () async {},
                child: Text(
                  '${StringManager.forgotPassword}?',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: ColorManager.subtitleText,
                  ),
                ),
              ),
            ),
            WidgetManager.primaryButton(
              buttonName: StringManager.signIn,
              isEnable: controller.isEnable,
              onTap: () async {},
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30.h,
              ),
              child: Row(
                children: [
                  Text(
                    '${StringManager.noAccount}? ',
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: ColorManager.subtitleText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Text(
                      StringManager.signUp,
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
      )),
    );
  }
}
