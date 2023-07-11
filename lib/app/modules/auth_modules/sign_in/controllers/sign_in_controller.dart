import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/auth_services/sign_in_service.dart';
import 'package:my_outdoor_footprint/app/data/utils/token_manager.dart';

import '../../../../data/services/auth_services/forgot_password_services/send_email_service.dart';
import '../../../../data/utils/widget_manager.dart';

class SignInController extends GetxController {
  final signInService = SignInService();
  final sendEmailService = SendEmailService();
  final signInKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  var obscurePasswordText = true.obs;
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

  Future<void> signIn() async {
    try {
      WidgetManager.showCustomDialog();

      final signInResponse = await signInService.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      if (signInResponse['status'] == true) {
        WidgetManager.customSnackBar(
          title: signInResponse['message'],
          type: SnackBarType.success,
        );
        await TokenManager.saveTokens(
          accessToken: signInResponse['tokens']['access']['token'],
          refreshToken: signInResponse['tokens']['refresh']['token'],
        );
        await Get.offAllNamed(
          '/navigation-bar',
        );
      } else {
        await TokenManager.saveTokens(
          accessToken: signInResponse['tokens']['access']['token'],
          refreshToken: signInResponse['tokens']['refresh']['token'],
        );
        final sendEmailResponse = await sendEmailService.sendVerificationEmail(
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
            'page': 'signIn',
          },
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

  void updateButtonState(String value) {
    if (!signInKey.currentState!.validate() ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
