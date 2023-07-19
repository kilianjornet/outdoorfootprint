import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/misc_services/device_token_service.dart';

import '../../../../../data/services/auth_services/forgot_password_services/send_email_service.dart';
import '../../../../../data/services/auth_services/forgot_password_services/verify_otp_service.dart';
import '../../../../../data/utils/token_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class VerifyOtpController extends GetxController {
  final sendEmailService = SendEmailService();
  final verifyEmailService = VerifyEmailService();
  final deviceTokenService = DeviceTokenService();
  final verifyOtpKey = GlobalKey<FormState>();
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpNodes;
  final int numberOfFields = 6;
  var isEnable = false.obs;
  RxInt secondsRemaining = 59.obs;
  Timer? timer;
  var arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    generateOtp();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    for (int i = 0; i < numberOfFields; i++) {
      otpControllers[i].dispose();
      otpNodes[i].dispose();
    }
    super.onClose();
  }

  Future<void> resendEmail() async {
    try {
      WidgetManager.showCustomDialog();

      if (arguments['page'] == 'forget') {
        final sendEmailResponse = await sendEmailService.sendForgotEmail(
          email: arguments['email'],
        );
        WidgetManager.customSnackBar(
          title: sendEmailResponse['message'],
          type: SnackBarType.info,
        );
      } else {
        final sendEmailResponse = await sendEmailService.sendVerificationEmail(
          email: arguments['email'],
        );
        WidgetManager.customSnackBar(
          title: sendEmailResponse['message'],
          type: SnackBarType.info,
        );
      }
      resendCode();
    } catch (e) {
      WidgetManager.customSnackBar(
        title: '$e',
        type: SnackBarType.error,
      );
    } finally {
      WidgetManager.hideCustomDialog();
    }
  }

  Future<void> verifyOtp() async {
    try {
      WidgetManager.showCustomDialog();

      final otp = joinOtpFromControllers(otpControllers);

      if (arguments['page'] == 'forget') {
        final verifyEmailResponse =
            await verifyEmailService.verifyForgotPassword(
          email: arguments['email'],
          otp: otp,
        );
        WidgetManager.customSnackBar(
          title: verifyEmailResponse['message'],
          type: SnackBarType.success,
        );
        await Get.toNamed(
          '/reset-password',
          arguments: verifyEmailResponse['token'],
        );
      } else {
        final verifyEmailResponse = await verifyEmailService.verifyEmail(
          otp: otp,
        );
        final deviceToken = await TokenManager.getDeviceToken();
        await deviceTokenService.addToken(
          deviceToken: '$deviceToken',
        );
        WidgetManager.customSnackBar(
          title: verifyEmailResponse['message'],
          type: SnackBarType.success,
        );
        await Get.offAllNamed(
          '/navigation-bar',
        );
      }
    } catch (e) {
      WidgetManager.customSnackBar(
        title: '$e',
        type: SnackBarType.error,
      );
    } finally {
      WidgetManager.hideCustomDialog();
    }
  }

  void generateOtp() {
    otpControllers = List.generate(
      numberOfFields,
      (_) => TextEditingController(),
    );
    otpNodes = List.generate(
      numberOfFields,
      (_) => FocusNode(),
    );
  }

  String joinOtpFromControllers(List<TextEditingController> controllers) {
    String otp = '';
    for (var controller in controllers) {
      otp += controller.text;
    }
    return otp;
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (secondsRemaining.value > 0) {
          secondsRemaining.value--;
        } else {
          timer.cancel();
        }
      },
    );
  }

  void resendCode() {
    secondsRemaining.value = 59;
    startTimer();
  }
}
