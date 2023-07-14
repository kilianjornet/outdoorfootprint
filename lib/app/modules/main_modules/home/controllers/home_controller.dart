import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/crud_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/token_manager.dart';

import '../../../../data/services/main_services/profile_service.dart';
import '../../../../data/utils/widget_manager.dart';

class HomeController extends GetxController {
  final profileService = ProfileService();
  final appBarKey = GlobalKey();
  var totalKg = '1736.13';
  var totalTon = '1.73613';
  var co2Home = 0.0.obs;
  var co2Mobility = 0.0.obs;
  var co2Gear = 0.0.obs;
  var co2Food = 0.0.obs;
  List<RxBool> isEnable = List.generate(2, (index) => true.obs);
  var openDialog = false.obs;
  var profileImage = ''.obs;
  var firstName = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    var id = await CrudManager.getId();
    if (id == null) {
      await getProfile();
    }
    profileImage.value = '${await CrudManager.getProfileImage()}';
    firstName.value = '${await CrudManager.getFirstName()}';
    co2Home.value = 20.0;
    co2Mobility.value = 35.0;
    co2Gear.value = 25.0;
    co2Food.value = 20.0;
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getProfile() async {
    try {
      WidgetManager.showCustomDialog();

      final profileResponse = await profileService.getProfile();
      await CrudManager.saveUserData(
        id: profileResponse['user']['id'],
        phoneNumber: profileResponse['user']['phoneNumber'],
        email: profileResponse['user']['email'],
        lastName: profileResponse['user']['lastName'],
        firstName: profileResponse['user']['firstName'],
        country: profileResponse['user']['address'],
        profileImage: profileResponse['user']['profile_image'],
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

  Future<void> logout() async {
    try {
      WidgetManager.showCustomDialog();

      await TokenManager.clearTokens();
      await CrudManager.clearUserData();
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
}
