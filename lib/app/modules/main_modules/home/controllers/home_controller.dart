import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/home_service.dart';
import 'package:my_outdoor_footprint/app/data/services/misc_services/device_token_service.dart';
import 'package:my_outdoor_footprint/app/data/utils/crud_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/token_manager.dart';

import '../../../../data/services/main_services/profile_service.dart';
import '../../../../data/utils/widget_manager.dart';

class HomeController extends GetxController {
  final homeService = HomeService();
  final profileService = ProfileService();
  final deviceTokenService = DeviceTokenService();
  final appBarKey = GlobalKey();
  var totalKg = 0.00.obs;
  var totalTon = 0.00.obs;
  var co2Home = 0.00.obs;
  var co2Mobility = 0.00.obs;
  var co2Gear = 0.00.obs;
  var co2Food = 0.00.obs;
  var co2Public = 0.00.obs;
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
    await getUserTotal();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUserTotal() async {
    try {
      WidgetManager.showCustomDialog();

      final homeResponse = await homeService.getUserTotal();
      co2Home.value = double.tryParse(
          '${homeResponse['allCalculationByUserId']['totalHomeCo2']}')!;
      co2Mobility.value = double.tryParse(
          '${homeResponse['allCalculationByUserId']['totalMobilityCo2']}')!;
      co2Gear.value = double.tryParse(
          '${homeResponse['allCalculationByUserId']['totalGearCo2']}')!;
      co2Food.value = double.tryParse(
          '${homeResponse['allCalculationByUserId']['totalOtherCo2']}')!;
      co2Public.value = double.tryParse(
          '${homeResponse['allCalculationByUserId']['totalPublicShareCo2']}')!;
      totalKg.value = double.tryParse(
          '${homeResponse['allCalculationByUserId']['totalKgOfCo2']}')!;
      totalTon.value = double.tryParse(
          '${homeResponse['allCalculationByUserId']['totalTonsOfCo2']}')!;
    } catch (e) {
      WidgetManager.customSnackBar(
        title: '$e',
        type: SnackBarType.error,
      );
    } finally {
      WidgetManager.hideCustomDialog();
    }
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

      final deviceToken = await TokenManager.getDeviceToken();
      await deviceTokenService.removeToken(
        deviceToken: '$deviceToken',
      );
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
