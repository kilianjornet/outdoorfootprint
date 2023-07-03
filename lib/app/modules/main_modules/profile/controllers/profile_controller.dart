import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

class ProfileController extends GetxController {
  final profileKey = GlobalKey<FormState>();
  FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final numberController = TextEditingController();
  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final emailNode = FocusNode();
  final countryNode = FocusNode();
  final numberNode = FocusNode();
  var country = ''.obs;
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

  void updateButtonState(dynamic value) {
    if (!profileKey.currentState!.validate() ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        countryController.text.isEmpty ||
        numberController.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
