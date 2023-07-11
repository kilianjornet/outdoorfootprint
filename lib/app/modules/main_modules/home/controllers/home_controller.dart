import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/crud_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/token_manager.dart';

import '../../../../data/utils/widget_manager.dart';

class HomeController extends GetxController {
  final appBarKey = GlobalKey();
  var totalKg = '1736.13';
  var totalTon = '1.73613';
  List<double> dataPoints = [40, 30, 15, 15];
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
    profileImage.value = '${await CrudManager.getProfileImage()}';
  }

  @override
  void onClose() {
    super.onClose();
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
