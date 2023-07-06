import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
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
