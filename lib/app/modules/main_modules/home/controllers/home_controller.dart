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
  var dataPoints = [20.0, 30.0, 25.0, 25.0].obs;
  List<RxBool> isEnable = List.generate(2, (index) => true.obs);
  var openDialog = false.obs;
  var profileImage = ''.obs;

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

  double getTotalValue() {
    return dataPoints.fold(0, (previous, current) => previous + current);
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
