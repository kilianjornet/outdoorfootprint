import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/auth_services/sign_up_service.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

class SignUpController extends GetxController {
  final signUpService = SignUpService();
  final signUpKey = GlobalKey<FormState>();
  FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final emailNode = FocusNode();
  final countryNode = FocusNode();
  final numberNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  var country = ''.obs;
  var obscurePasswordText = true.obs;
  var obscureConfirmPasswordText = true.obs;
  var isChecked = false.obs;
  var isEnable = false.obs;
  @override
  void onInit() {
    super.onInit();
    countryPicker = FlCountryCodePicker(
      localize: false,
      showDialCode: false,
      title: WidgetManager.countryPickerTitle(),
      countryTextStyle: WidgetManager.countryTextStyle(),
      searchBarDecoration: WidgetManager.searchBarDecoration(),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> signUp() async {
    try {
      WidgetManager.showCustomDialog();

      final signUpResponse = await signUpService.signUp(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        address: countryController.text,
        phoneNumber: numberController.text,
        password: passwordController.text,
      );
      WidgetManager.customSnackBar(
        title: signUpResponse['message'],
        type: SnackBarType.info,
      );
      await Get.toNamed(
        '/verify-otp',
        arguments: {
          'email': emailController.text,
          'page': 'signUp',
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

  void updateButtonState(dynamic value) {
    if (!signUpKey.currentState!.validate() ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        countryController.text.isEmpty ||
        numberController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        isChecked.value == false) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
