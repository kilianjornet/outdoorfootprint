import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/services/auth_services/forgot_password_services/reset_password_service.dart';
import '../../../../../data/utils/widget_manager.dart';

class ResetPasswordController extends GetxController {
  final resetPasswordService = ResetPasswordService();
  final resetPasswordKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  var obscurePasswordText = true.obs;
  var obscureConfirmPasswordText = true.obs;
  var isEnable = false.obs;
  var arguments = Get.arguments;

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

  Future<void> resetPassword() async {
    try {
      WidgetManager.showCustomDialog();

      final resetPasswordResponse = await resetPasswordService.resetPassword(
        token: '$arguments',
        password: passwordController.text,
      );
      WidgetManager.customSnackBar(
        title: resetPasswordResponse['message'],
        type: SnackBarType.success,
      );
      await Get.offAllNamed(
        '/sign-in',
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
