import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';
import 'package:my_outdoor_footprint/app/modules/auth_modules/forgot_password_modules/verify_otp/widgets/verify_otp_widget.dart';

import '../../../../../data/utils/color_manager.dart';
import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetManager.primaryAppBar(),
      body: WidgetManager.authBackground(
        title: StringManager.verifyOtpTitle,
        appBar: true,
        child: Column(
          children: [
            VerifyOtpWidget.otpTextField(
              numberOfFields: controller.numberOfFields,
              otpControllers: controller.otpControllers,
              otpNodes: controller.otpNodes,
              isEnable: controller.isEnable,
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
            Obx(
              () {
                return controller.secondsRemaining.value == 1
                    ? Text(
                        '${controller.secondsRemaining.value} ${StringManager.second}',
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: ColorManager.subtitleText,
                        ),
                      )
                    : controller.secondsRemaining.value >= 2
                        ? Text(
                            '${controller.secondsRemaining.value} ${StringManager.seconds}',
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: ColorManager.subtitleText,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              controller.resendCode();
                            },
                            child: Text(
                              StringManager.resend,
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: ColorManager.subtitleText,
                              ),
                            ),
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
