import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/modules/auth_modules/sign_up/widgets/signup_widget.dart';

class SignUpController extends GetxController {
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
      title: SignUpWidget.countryPickerTitle(),
      countryTextStyle: SignUpWidget.countryTextStyle(),
      searchBarDecoration: SignUpWidget.searchBarDecoration(),
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

  void updateButtonState(dynamic value) {
    if (!signUpKey.currentState!.validate() ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        countryController.text.isEmpty ||
        numberController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        isChecked.value == false) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
