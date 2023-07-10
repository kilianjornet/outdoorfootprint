import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/auth_services/forgot_password_services/send_email_service.dart';

import '../../../../../data/utils/widget_manager.dart';

class SendEmailController extends GetxController {
  final sendEmailService = SendEmailService();
  final sendEmailKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailNode = FocusNode();
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

  Future<void> sendEmail() async {
    try {
      WidgetManager.showCustomDialog();

      final sendEmailResponse = await sendEmailService.sendForgotEmail(
        email: emailController.text,
      );
      WidgetManager.customSnackBar(
        title: sendEmailResponse['message'],
        type: SnackBarType.info,
      );
      await Get.toNamed(
        '/verify-otp',
        arguments: {
          'email': emailController.text,
          'page': 'forget',
        },
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

  void updateButtonState(String value) {
    if (!sendEmailKey.currentState!.validate() ||
        emailController.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
