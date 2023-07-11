import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/calculator_services/gear_service.dart';

import '../../../../../data/utils/crud_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class GearController extends GetxController {
  //TODO: Implement GearController

  final count = 0.obs;
  var isEnable = true.obs;
  var dropdownValue = "".obs;
  var total = 0.0.obs;
  final gearService = GearService();
  var sum = 0.0.obs;
  var selectedDropdownValue1 = "1".obs;
  var selectedDropdownValue2 = "".obs;
  var selectedDropdownValue3 = "".obs;
  var selectedDropdownValue4 = "".obs;
  var selectedDropdownValue5 = "".obs;
  var selectedDropdownValue6 = "".obs;
  var selectedDropdownValue7 = "".obs;
  var selectedDropdownValue8 = "".obs;
  var selectedDropdownValue9 = "".obs;
  var selectedDropdownValue10 = "".obs;
  var selectedDropdownValue11 = "".obs;
  var selectedDropdownValue12 = "".obs;
  var selectedDropdownValue13 = "".obs;
  var selectedDropdownValue14 = "".obs;
  var selectedDropdownValue15 = "".obs;
  var selectedDropdownValue16 = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (kDebugMode) {
      print(dropdownValue.value);
    }
  }

  @override
  void onClose() {
    selectedDropdownValue1.close();
    selectedDropdownValue2.close();
    selectedDropdownValue3.close();
    selectedDropdownValue4.close();
    super.onClose();
  }

  Future<void> submitGears() async {
    try {
      WidgetManager.showCustomDialog();

      final userId = await CrudManager.getId();
      final houseResponse = await gearService.submitGear(
        userId: '$userId',
        totalKgCo2OfGear: '$total',
      );
      WidgetManager.customSnackBar(
        title: houseResponse['message'],
        type: SnackBarType.success,
      );
      await Get.offNamed('/navigation-bar');
    } catch (e) {
      WidgetManager.customSnackBar(
        title: '$e',
        type: SnackBarType.error,
      );
    } finally {
      WidgetManager.hideCustomDialog();
    }
  }

  void calculateConversion() {
    final labelValue1 = double.tryParse(selectedDropdownValue1.value) ?? 1.0;
    final labelValue2 = double.tryParse(selectedDropdownValue2.value) ?? 1.0;
    final labelValue3 = double.tryParse(selectedDropdownValue3.value) ?? 1.0;
    final labelValue4 = double.tryParse(selectedDropdownValue4.value) ?? 1.0;
    final labelValue5 = double.tryParse(selectedDropdownValue5.value) ?? 1.0;
    final labelValue6 = double.tryParse(selectedDropdownValue6.value) ?? 1.0;
    final labelValue7 = double.tryParse(selectedDropdownValue7.value) ?? 1.0;
    final labelValue8 = double.tryParse(selectedDropdownValue8.value) ?? 1.0;
    final labelValue9 = double.tryParse(selectedDropdownValue9.value) ?? 1.0;
    final labelValue10 = double.tryParse(selectedDropdownValue10.value) ?? 1.0;
    final labelValue11 = double.tryParse(selectedDropdownValue11.value) ?? 1.0;
    final labelValue12 = double.tryParse(selectedDropdownValue12.value) ?? 1.0;
    final labelValue13 = double.tryParse(selectedDropdownValue13.value) ?? 1.0;
    final labelValue14 = double.tryParse(selectedDropdownValue14.value) ?? 1.0;
    final labelValue15 = double.tryParse(selectedDropdownValue15.value) ?? 1.0;
    final labelValue16 = double.tryParse(selectedDropdownValue16.value) ?? 1.0;
    sum.value = labelValue1 +
        labelValue2 +
        labelValue3 +
        labelValue4 +
        labelValue5 +
        labelValue6 +
        labelValue7 +
        labelValue8 +
        labelValue9 +
        labelValue10 +
        labelValue11 +
        labelValue12 +
        labelValue13 +
        labelValue14 +
        labelValue15 +
        labelValue16;
  }
}
