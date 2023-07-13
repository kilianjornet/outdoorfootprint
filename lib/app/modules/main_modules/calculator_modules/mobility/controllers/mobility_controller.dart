import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/calculator_services/mobility_service.dart';

import '../../../../../data/utils/crud_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class MobilityController extends GetxController {
  final mobilityService = MobilityService();
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

  Future<void> submitMobility() async {
    try {
      WidgetManager.showCustomDialog();

      final userId = await CrudManager.getId();
      final mobilityResponse = await mobilityService.submitMobility(
        userId: '$userId',
        totalKgCo2OfMobility: '${total.value}',
      );
      WidgetManager.customSnackBar(
        title: mobilityResponse['message'],
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

  void updateButtonState(dynamic value) {
    if (total.value == 0.0 || total.value.isNaN) {
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
    const co2PlaneConversion = 92;
    const co2BusConversion = 0.25;
    const co2TrainConversion = 0.2;
    final carKg = calculateCarSIUnit(
        distanceController, quantityController, distanceConversion);
    final busSiUnit = calculateSIUnit(busController, busConversion);
    final trainSiUnit = calculateSIUnit(trainController, trainConversion);
    final planeValue = double.tryParse(planeController.text) ?? 0.0;
    final helicopterValue = double.tryParse(helicopterController.text) ?? 0.0;
    final planeKg = planeValue * co2PlaneConversion;
    final busKg = busSiUnit * co2BusConversion;
    final trainKg = trainSiUnit * co2TrainConversion;
    final helicopterKg = helicopterValue * 10;
    total.value = carKg + planeKg + busKg + trainKg + helicopterKg;
  }

  double calculateCarSIUnit(TextEditingController primaryController,
      TextEditingController secondaryController, RxDouble conversionValue) {
    const co2PetrolConversion = 0.24;
    const co2DieselConversion = 0.24;
    final co2ConversionValue = conversionValue.value == 9.58
        ? co2PetrolConversion
        : co2DieselConversion;
    double distance = double.tryParse(primaryController.text) ?? 0.0;
    double quantity = double.tryParse(secondaryController.text) ?? 0.0;
    return ((distance / 100 * quantity) * conversionValue.value) *
        co2ConversionValue;
  }

  double calculateSIUnit(
      TextEditingController controller, RxDouble conversionValue) {
    final controllerValue = double.tryParse(controller.text) ?? 0.0;
    return controllerValue * conversionValue.value;
  }
}
