import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final resetPasswordKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  var obscurePasswordText = true.obs;
  var obscureConfirmPasswordText = true.obs;
  var isEnable = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateButtonState(dynamic value) {
    if (!resetPasswordKey.currentState!.validate() ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
