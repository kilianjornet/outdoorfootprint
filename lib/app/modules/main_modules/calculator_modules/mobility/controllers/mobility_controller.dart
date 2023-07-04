import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/utils/string_manager.dart';

class MobilityController extends GetxController {
  final quantityController = TextEditingController();
  final distanceController = TextEditingController();
  final planeController = TextEditingController();
  final busController = TextEditingController();
  final trainController = TextEditingController();
  final helicopterController = TextEditingController();
  final quantityNode = FocusNode();
  final distanceNode = FocusNode();
  final planeNode = FocusNode();
  final busNode = FocusNode();
  final trainNode = FocusNode();
  final helicopterNode = FocusNode();
  var quantityUnit = StringManager.literPerKm.obs;
  var distanceUnit = StringManager.litersPetrol.obs;
  var isEnable = false.obs;
  var total = 0.0.obs;
  var distanceConversion = 9.58.obs;
  var busConversion = 0.284.obs;
  var trainConversion = 0.2.obs;
  var helicopterConversion = 10.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    quantityController.text = '0';
    distanceController.text = '0';
    planeController.text = '0';
    busController.text = '0';
    trainController.text = '0';
    helicopterController.text = '0';
  }

  @override
  void onClose() {
    quantityController.dispose();
    distanceController.dispose();
    planeController.dispose();
    busController.dispose();
    trainController.dispose();
    helicopterController.dispose();
    super.onClose();
  }

  void updateButtonState(dynamic value) {
    if (quantityController.text.isEmpty ||
        distanceController.text.isEmpty ||
        planeController.text.isEmpty ||
        busController.text.isEmpty ||
        trainController.text.isEmpty ||
        helicopterController.text.isEmpty ||
        total.value == 0.0 ||
        total.value.isNaN) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }

  void selectQuantityUnit(String unit) {
    quantityUnit.value = unit;
  }

  void selectDistanceUnit(String unit) {
    distanceUnit.value = unit;
  }

  Widget buildQuantityRadio({
    required String unitTitle,
    required var unitValue,
  }) {
    return Obx(
      () {
        return CupertinoRadio(
          value: unitTitle,
          groupValue: unitValue.value,
          onChanged: (value) {
            selectQuantityUnit(
              value.toString(),
            );
            calculateTotalCarbon();
            Get.back();
          },
        );
      },
    );
  }

  Widget buildDistanceRadio({
    required String unitTitle,
    required var unitValue,
  }) {
    return Obx(
      () {
        return CupertinoRadio(
          value: unitTitle,
          groupValue: unitValue.value,
          onChanged: (value) {
            selectDistanceUnit(
              value.toString(),
            );
            unitTitle == StringManager.litersPetrol
                ? distanceConversion.value = 9.58
                : distanceConversion.value = 10.52;
            calculateTotalCarbon();
            Get.back();
          },
        );
      },
    );
  }

  void calculateTotalCarbon() {
    final carSiUnit = calculateCarSIUnit(
        distanceController, quantityController, distanceConversion);
    final busSiUnit = calculateSIUnit(busController, busConversion);
    final trainSiUnit = calculateSIUnit(trainController, trainConversion);
    final planeValue = double.tryParse(planeController.text) ?? 0.0;
    final helicopterValue = double.tryParse(helicopterController.text) ?? 0.0;
    final carKg = carSiUnit * 0.19;
    final planeKg = planeValue * 92;
    final busKg = busSiUnit * 0.25;
    final trainKg = trainSiUnit * 0.25;
    final helicopterKg = helicopterValue * 10;
    total.value = carKg + planeKg + busKg + trainKg + helicopterKg;
  }

  double calculateCarSIUnit(TextEditingController primaryController,
      TextEditingController secondaryController, RxDouble conversionValue) {
    double distance = double.tryParse(primaryController.text) ?? 0.0;
    double quantity = double.tryParse(secondaryController.text) ?? 0.0;
    return (distance / 100 * quantity) * conversionValue.value;
  }

  double calculateSIUnit(
      TextEditingController controller, RxDouble conversionValue) {
    final controllerValue = double.tryParse(controller.text) ?? 0.0;
    return controllerValue * conversionValue.value;
  }
}
