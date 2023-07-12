import 'dart:io';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/profile_service.dart';
import 'package:my_outdoor_footprint/app/data/utils/crud_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

class ProfileController extends GetxController {
  final profileService = ProfileService();
  final profileKey = GlobalKey<FormState>();
  FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  final ImagePicker picker = ImagePicker();
  Rx<File?> image = Rx<File?>(null);
  File? get selectedImage => image.value;
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
  var profileImage = ''.obs;
  var isEnable = true.obs;

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
  void onReady() async {
    super.onReady();
    firstNameController.text = '${await CrudManager.getFirstName()}';
    lastNameController.text = '${await CrudManager.getLastName()}';
    emailController.text = '${await CrudManager.getEmail()}';
    countryController.text = '${await CrudManager.getCountry()}';
    numberController.text = '${await CrudManager.getPhoneNumber()}';
    profileImage.value = '${await CrudManager.getProfileImage()}';
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    countryController.dispose();
    numberController.dispose();
    super.onClose();
  }

  Future<void> updateProfile() async {
    try {
      WidgetManager.showCustomDialog();
      final id = await CrudManager.getId();

      final profileResponse = await profileService.updateProfile(
        id: '$id',
        profileImage: image.value == null ? '' : selectedImage!.path,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        address: countryController.text,
        phoneNumber: numberController.text,
      );
      await CrudManager.saveUserData(
        id: profileResponse['user']['id'],
        phoneNumber: profileResponse['user']['phoneNumber'],
        email: profileResponse['user']['email'],
        lastName: profileResponse['user']['lastName'],
        firstName: profileResponse['user']['firstName'],
        country: profileResponse['user']['address'],
        profileImage: profileResponse['user']['profile_image'],
      );

      WidgetManager.customSnackBar(
        title: profileResponse['message'],
        type: SnackBarType.success,
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

  void pickImage({
    required ImageSource imageSource,
  }) async {
    final pickedImage = await picker.pickImage(
      source: imageSource,
      imageQuality: 70,
      requestFullMetadata: true,
    );

    if (pickedImage != null) {
      image.value = File(
        pickedImage.path,
      );
      Get.back();
    }
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
