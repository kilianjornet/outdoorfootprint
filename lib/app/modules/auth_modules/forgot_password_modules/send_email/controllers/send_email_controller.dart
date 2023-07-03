import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SendEmailController extends GetxController {
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

  void updateButtonState(String value) {
    if (!sendEmailKey.currentState!.validate() ||
        emailController.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
