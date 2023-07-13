import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/calculator_services/house_service.dart';
import 'package:my_outdoor_footprint/app/data/utils/crud_manager.dart';

import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class HouseController extends GetxController {
  final houseService = HouseService();
  final adultController = TextEditingController();
  final gasController = TextEditingController();
  final coalController = TextEditingController();
  final woodController = TextEditingController();
  final oilController = TextEditingController();
  final solarController = TextEditingController();
  final electricityController = TextEditingController();
  final electricityCoalController = TextEditingController();
  final electricityOilController = TextEditingController();
  final electricityGasController = TextEditingController();
  final electricityNuclearController = TextEditingController();
  final electricityHydroController = TextEditingController();
  final electricitySolarController = TextEditingController();
  final electricityWindController = TextEditingController();
  final electricityThermalController = TextEditingController();
  final electricityWoodController = TextEditingController();
  final electricityWasteController = TextEditingController();
  final dataController = TextEditingController();
  final modemController = TextEditingController();
  final adultNode = FocusNode();
  final gasNode = FocusNode();
  final coalNode = FocusNode();
  final woodNode = FocusNode();
  final oilNode = FocusNode();
  final solarNode = FocusNode();
  final electricityNode = FocusNode();
  final electricityCoalNode = FocusNode();
  final electricityOilNode = FocusNode();
  final electricityGasNode = FocusNode();
  final electricityNuclearNode = FocusNode();
  final electricityHydroNode = FocusNode();
  final electricitySolarNode = FocusNode();
  final electricityWindNode = FocusNode();
  final electricityThermalNode = FocusNode();
  final electricityWoodNode = FocusNode();
  final electricityWasteNode = FocusNode();
  final dataNode = FocusNode();
  final modemNode = FocusNode();
  var gasUnit = StringManager.cubicMeter.obs;
  var oilUnit = StringManager.litre.obs;
  var isEnable = false.obs;
  var total = 0.0.obs;
  var totalElectricity = 0.0.obs;
  var sum = 0.0.obs;
  var gasConversion = 10.0.obs;
  var coalConversion = 7.583.obs;
  var woodConversion = 2.778.obs;
  var oilConversion = 11.9.obs;
  var solarConversion = 1.0.obs;
  var internetConversion = 3.0.obs;

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
    electricityCoalController.text = '0';
    electricityOilController.text = '0';
    electricityGasController.text = '0';
    electricityNuclearController.text = '0';
    electricityHydroController.text = '0';
    electricitySolarController.text = '0';
    electricityWindController.text = '0';
    electricityThermalController.text = '0';
    electricityWoodController.text = '0';
    electricityWasteController.text = '0';
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
    electricityCoalController.dispose();
    electricityOilController.dispose();
    electricityGasController.dispose();
    electricityNuclearController.dispose();
    electricityHydroController.dispose();
    electricitySolarController.dispose();
    electricityWindController.dispose();
    electricityThermalController.dispose();
    electricityWoodController.dispose();
    electricityWasteController.dispose();
    dataController.dispose();
    modemController.dispose();
    super.onClose();
  }

  Future<void> submitHouse() async {
    try {
      WidgetManager.showCustomDialog();

      final userId = await CrudManager.getId();
      final houseResponse = await houseService.submitHouse(
        userId: '$userId',
        totalKgCo2OfHome: '$total',
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

  void updateButtonState(dynamic value) {
    if (total.value == 0 ||
        (sum.value >= 0.1 && sum.value <= 99.9) ||
        total.value.isNaN) {
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
                : oilConversion.value = 12;
            calculateTotalCarbon();
            Get.back();
          },
        );
      },
    );
  }

  void calculateComposition() {
    final coalSiUnit = calculateElectricity(electricityCoalController);
    final oilSiUnit = calculateElectricity(electricityOilController);
    final gasSiUnit = calculateElectricity(electricityGasController);
    final nuclearSiUnit = calculateElectricity(electricityNuclearController);
    final hydroSiUnit = calculateElectricity(electricityHydroController);
    final solarSiUnit = calculateElectricity(electricitySolarController);
    final windSiUnit = calculateElectricity(electricityWindController);
    final thermalSiUnit = calculateElectricity(electricityThermalController);
    final woodSiUnit = calculateElectricity(electricityWoodController);
    final wasteSiUnit = calculateElectricity(electricityWasteController);

    final coalKg = coalSiUnit * 0.9;
    final oilKg = oilSiUnit * 0.7;
    final gasKg = gasSiUnit * 0.36;
    final nuclearKg = nuclearSiUnit * 0.02;
    final hydroKg = hydroSiUnit * 0.003;
    final solarKg = solarSiUnit * 0.05;
    final windKg = windSiUnit * 0.01;
    final thermalKg = thermalSiUnit * 0.03;
    final woodKg = woodSiUnit * 0.0;
    final wasteKg = wasteSiUnit * 0.0;
    totalElectricity.value = gasKg +
        coalKg +
        woodKg +
        oilKg +
        solarKg +
        nuclearKg +
        hydroKg +
        windKg +
        thermalKg +
        wasteKg;
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
    final electricityKg =
        double.tryParse(electricityController.text)! * totalElectricity.value;
    final dataKg = double.tryParse(dataController.text)! * 3;
    final modemKg =
        calculateSIUnit(modemController, internetConversion) / adultValue;
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

  void calculateConversion() {
    final coalValue = double.tryParse(electricityCoalController.text) ?? 0.0;
    final oilValue = double.tryParse(electricityOilController.text) ?? 0.0;
    final gasValue = double.tryParse(electricityGasController.text) ?? 0.0;
    final nuclearValue =
        double.tryParse(electricityNuclearController.text) ?? 0.0;
    final hydroValue = double.tryParse(electricityHydroController.text) ?? 0.0;
    final solarValue = double.tryParse(electricitySolarController.text) ?? 0.0;
    final windValue = double.tryParse(electricityWindController.text) ?? 0.0;
    final thermalValue =
        double.tryParse(electricityThermalController.text) ?? 0.0;
    final woodValue = double.tryParse(electricityWoodController.text) ?? 0.0;
    final wasteValue = double.tryParse(electricityWasteController.text) ?? 0.0;
    sum.value = coalValue +
        oilValue +
        gasValue +
        nuclearValue +
        hydroValue +
        solarValue +
        windValue +
        thermalValue +
        woodValue +
        wasteValue;
  }

  double calculateElectricity(TextEditingController controller) {
    final controllerValue = double.tryParse(controller.text) ?? 0.0;
    // final electricityValue = double.tryParse(electricityController.text) ?? 0.0;
    // final adultValue = double.tryParse(adultController.text) ?? 0.0;
    final result = controllerValue / 100;
    // return result / 100;
    return result;
  }
}
