import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/services/auth_services/forgot_password_services/send_email_service.dart';
import '../../../../../data/utils/widget_manager.dart';

class VerifyOtpController extends GetxController {
  final sendEmailService = SendEmailService();
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

      final sendEmailResponse = await sendEmailService.sendEmail(
        email: arguments['email'],
      );
      resendCode();
      WidgetManager.customSnackBar(
        title: sendEmailResponse['message'],
        type: SnackBarType.info,
      );
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

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode() {
    secondsRemaining.value = 59;
    startTimer();
  }
}
