import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';
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
      body: WidgetManager.authBackground(
        title: StringManager.verifyOtpTitle,
        subtitle: controller.arguments['email'],
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
                buttonName: StringManager.verify,
                isEnable: controller.isEnable,
                onTap: () async {
                  Get.toNamed('/reset-password');
                },
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
                              await controller.resendEmail();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetManager.resend,
                                  width: 15.w,
                                ),
                                Text(
                                  '  ${StringManager.resend}',
                                  style: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: ColorManager.subtitleText,
                                  ),
                                ),
                              ],
                            ),
                          );
              },
            ),
            controller.arguments['page'] == 'forget'
                ? WidgetManager.backToSignIn()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
