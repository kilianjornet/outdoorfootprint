import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/utils/string_manager.dart';

class HouseController extends GetxController {
  final adultController = TextEditingController();
  final gasController = TextEditingController();
  final coalController = TextEditingController();
  final woodController = TextEditingController();
  final oilController = TextEditingController();
  final solarController = TextEditingController();
  final electricityController = TextEditingController();
  final dataController = TextEditingController();
  final modemController = TextEditingController();
  final adultNode = FocusNode();
  final gasNode = FocusNode();
  final coalNode = FocusNode();
  final woodNode = FocusNode();
  final oilNode = FocusNode();
  final solarNode = FocusNode();
  final electricityNode = FocusNode();
  final dataNode = FocusNode();
  final modemNode = FocusNode();
  var gasUnit = StringManager.cubicMeter.obs;
  var oilUnit = StringManager.litre.obs;
  var isEnable = true.obs;
  var total = 0.0.obs;
  var gasConversion = 10.0.obs;
  var coalConversion = 7.583.obs;
  var woodConversion = 2.778.obs;
  var oilConversion = 11.9.obs;
  var solarConversion = 1.0.obs;

  final conversionValues = {
    'gas': 10.0.obs,
    'coal': 7.583.obs,
    'wood': 2.778.obs,
    'oil': 11.9.obs,
    'solar': 1.obs,
  };

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    adultController.text = '1';
    gasController.text = '0';
    coalController.text = '0';
    woodController.text = '0';
    oilController.text = '0';
    solarController.text = '0';
    electricityController.text = '0';
    dataController.text = '0';
    modemController.text = '0';
  }

  @override
  void onClose() {
    adultController.dispose();
    gasController.dispose();
    coalController.dispose();
    woodController.dispose();
    oilController.dispose();
    solarController.dispose();
    electricityController.dispose();
    dataController.dispose();
    modemController.dispose();
    super.onClose();
  }

  void updateButtonState(dynamic value) {
    if (adultController.text.isEmpty ||
        gasController.text.isEmpty ||
        coalController.text.isEmpty ||
        woodController.text.isEmpty ||
        oilController.text.isEmpty ||
        solarController.text.isEmpty ||
        electricityController.text.isEmpty ||
        dataController.text.isEmpty ||
        modemController.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }

  void selectGasUnit(String unit) {
    gasUnit.value = unit;
  }

  void selectOilUnit(String unit) {
    oilUnit.value = unit;
  }

  Widget buildGasRadio({
    required String unitTitle,
    required var unitValue,
  }) {
    return Obx(
      () {
        return CupertinoRadio(
          value: unitTitle,
          groupValue: unitValue.value,
          onChanged: (value) {
            selectGasUnit(
              value.toString(),
            );
            unitTitle == StringManager.cubicMeter
                ? gasConversion.value = 10
                : unitTitle == StringManager.cubicFeet
                    ? gasConversion.value = 28.32
                    : gasConversion.value = 1;
            calculateTotalCarbon();
            Get.back();
          },
        );
      },
    );
  }

  Widget buildOilRadio({
    required String unitTitle,
    required var unitValue,
  }) {
    return Obx(
      () {
        return CupertinoRadio(
          value: unitTitle,
          groupValue: unitValue.value,
          onChanged: (value) {
            selectOilUnit(
              value.toString(),
            );
            unitTitle == StringManager.litre
                ? oilConversion.value = 11.9
                : gasConversion.value = 12;
            calculateTotalCarbon();
            Get.back();
          },
        );
      },
    );
  }

  void calculateTotalCarbon() {
    final adultValue = double.tryParse(adultController.text) ?? 0.0;
    final gasSiUnit =
        calculateSIUnit(gasController, gasConversion) / adultValue;
    final coalSiUnit =
        calculateSIUnit(coalController, coalConversion) / adultValue;
    final woodSiUnit =
        calculateSIUnit(woodController, woodConversion) / adultValue;
    final oilSiUnit =
        calculateSIUnit(oilController, oilConversion) / adultValue;
    final solarSiUnit =
        calculateSIUnit(solarController, solarConversion) / adultValue;
    final gasKg = gasSiUnit * 0.19;
    final coalKg = coalSiUnit * 0.32;
    final woodKg = woodSiUnit * 0.25;
    final oilKg = oilSiUnit * 0.25;
    final solarKg = solarSiUnit * 0;
    final electricityKg = double.tryParse(electricityController.text)! * 0.0030;
    final dataKg = double.tryParse(dataController.text)! * 3;
    final modemKg = double.tryParse(modemController.text)! * 3;
    total.value = gasKg +
        coalKg +
        woodKg +
        oilKg +
        solarKg +
        electricityKg +
        dataKg +
        modemKg;
  }

  double calculateSIUnit(
      TextEditingController controller, RxDouble conversionValue) {
    final controllerValue = double.tryParse(controller.text) ?? 0.0;
    return controllerValue * conversionValue.value;
  }
}
