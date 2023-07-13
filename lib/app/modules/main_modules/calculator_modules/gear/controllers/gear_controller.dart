import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/calculator_services/gear_service.dart';

import '../../../../../data/utils/crud_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class GearController extends GetxController {
  //TODO: Implement GearController

  final count = 0.obs;
  var isEnable = true.obs;
  var isButtonEnable = false.obs;
  var dropdownValue = "".obs;
  var total = 0.0.obs;
  final gearService = GearService();
  var sum = 0.0.obs;
  var selectedDropdownValue1 = "0".obs;
  var selectedDropdownValue2 = "0".obs;
  var selectedDropdownValue3 = "0".obs;
  var selectedDropdownValue4 = "0".obs;
  var selectedDropdownValue5 = "0".obs;
  var selectedDropdownValue6 = "0".obs;
  var selectedDropdownValue7 = "0".obs;
  var selectedDropdownValue8 = "0".obs;
  var selectedDropdownValue9 = "0".obs;
  var selectedDropdownValue10 = "0".obs;
  var selectedDropdownValue11 = "0".obs;
  var selectedDropdownValue12 = "0".obs;
  var selectedDropdownValue13 = "0".obs;
  var selectedDropdownValue14 = "0".obs;
  var selectedDropdownValue15 = "0".obs;
  var selectedDropdownValue16 = "0".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    calculateConversion();
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
    total.close();
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
    final labelValue1 = double.tryParse(selectedDropdownValue1.value) ?? 0.0;
    final labelValue2 = double.tryParse(selectedDropdownValue2.value) ?? 0.0;
    final labelValue3 = double.tryParse(selectedDropdownValue3.value) ?? 0.0;
    final labelValue4 = double.tryParse(selectedDropdownValue4.value) ?? 0.0;
    final labelValue5 = double.tryParse(selectedDropdownValue5.value) ?? 0.0;
    final labelValue6 = double.tryParse(selectedDropdownValue6.value) ?? 0.0;
    final labelValue7 = double.tryParse(selectedDropdownValue7.value) ?? 0.0;
    final labelValue8 = double.tryParse(selectedDropdownValue8.value) ?? 0.0;
    final labelValue9 = double.tryParse(selectedDropdownValue9.value) ?? 0.0;
    final labelValue10 = double.tryParse(selectedDropdownValue10.value) ?? 0.0;
    final labelValue11 = double.tryParse(selectedDropdownValue11.value) ?? 0.0;
    final labelValue12 = double.tryParse(selectedDropdownValue12.value) ?? 0.0;
    final labelValue13 = double.tryParse(selectedDropdownValue13.value) ?? 0.0;
    final labelValue14 = double.tryParse(selectedDropdownValue14.value) ?? 0.0;
    final labelValue15 = double.tryParse(selectedDropdownValue15.value) ?? 0.0;

    final convertedValue1 = labelValue1 * 13.6;
    final convertedValue2 = labelValue2 * 45.2;
    final convertedValue3 = labelValue3 * 0.25;
    final convertedValue4 = labelValue4 * 12;
    final convertedValue5 = labelValue5 * 300;

    final convertedValue6 = labelValue6 * 15;
    final convertedValue7 = labelValue7 * 10;
    final convertedValue8 = labelValue8 * 18;
    final convertedValue9 = labelValue9 * 1.9;
    final convertedValue10 = labelValue10 * 9;

    final convertedValue11 = labelValue11 * 2;
    final convertedValue12 = labelValue12 * 6.1;
    final convertedValue13 = labelValue13 * 15;
    final convertedValue14 = labelValue14 * 1.8;
    final convertedValue15 = labelValue15 * 40;

    total.value = convertedValue1 +
        convertedValue2 +
        convertedValue3 +
        convertedValue4 +
        convertedValue5 +
        convertedValue6 +
        convertedValue7 +
        convertedValue8 +
        convertedValue9 +
        convertedValue10 +
        convertedValue11 +
        convertedValue12 +
        convertedValue13 +
        convertedValue14 +
        convertedValue15;
    if(total.value==0.0){
      isButtonEnable.value=false;
    }else {
      isButtonEnable.value=true;
    }
  }
}
