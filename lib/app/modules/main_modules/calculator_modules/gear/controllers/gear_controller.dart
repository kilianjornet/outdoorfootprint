import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/calculator_services/gear_service.dart';

import '../../../../../data/utils/crud_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class GearController extends GetxController {
  final gearService = GearService();
  final runningController = TextEditingController();
  final skisController = TextEditingController();
  final ropeController = TextEditingController();
  final gearController = TextEditingController();
  final bikeController = TextEditingController();
  final polyesterController = TextEditingController();
  final cottonController = TextEditingController();
  final jacketController = TextEditingController();
  final sockController = TextEditingController();
  final pantController = TextEditingController();
  final globeController = TextEditingController();
  final sportController = TextEditingController();
  final skiClothController = TextEditingController();
  final swimController = TextEditingController();
  final smartController = TextEditingController();
  final tentController = TextEditingController();
  final runningNode = FocusNode();
  final skisNode = FocusNode();
  final ropeNode = FocusNode();
  final gearNode = FocusNode();
  final bikeNode = FocusNode();
  final polyesterNode = FocusNode();
  final cottonNode = FocusNode();
  final jacketNode = FocusNode();
  final sockNode = FocusNode();
  final pantNode = FocusNode();
  final globeNode = FocusNode();
  final sportNode = FocusNode();
  final skiClothNode = FocusNode();
  final swimNode = FocusNode();
  final smartNode = FocusNode();
  final tentNode = FocusNode();
  var isEnable = false.obs;
  var total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    runningController.text = '0';
    skisController.text = '0';
    ropeController.text = '0';
    gearController.text = '0';
    bikeController.text = '0';
    polyesterController.text = '0';
    cottonController.text = '0';
    jacketController.text = '0';
    sockController.text = '0';
    pantController.text = '0';
    globeController.text = '0';
    sportController.text = '0';
    skiClothController.text = '0';
    swimController.text = '0';
    smartController.text = '0';
    tentController.text = '0';
  }

  @override
  void onClose() {
    runningController.dispose();
    skisController.dispose();
    ropeController.dispose();
    gearController.dispose();
    bikeController.dispose();
    polyesterController.dispose();
    cottonController.dispose();
    jacketController.dispose();
    sockController.dispose();
    pantController.dispose();
    globeController.dispose();
    sportController.dispose();
    skiClothController.dispose();
    swimController.dispose();
    smartController.dispose();
    tentController.dispose();
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
    const co2Running = 13.6;
    const co2Skis = 45.2;
    const co2Rope = 0.25;
    const co2Gear = 12.0;
    const co2Bike = 300.0;
    const co2Polyester = 15.0;
    const co2Cotton = 10.0;
    const co2Jacket = 18.0;
    const co2Sock = 1.9;
    const co2Pant = 9.0;
    const co2Globe = 2.0;
    const co2Sport = 6.1;
    const co2SkiCloth = 15.0;
    const co2Swim = 1.8;
    const co2Smart = 40.0;
    const co2Tent = 13.0;
    final runningKg = calculateKg(runningController, co2Running);
    final skisKg = calculateKg(skisController, co2Skis);
    final ropeKg = calculateKg(ropeController, co2Rope);
    final gearKg = calculateKg(gearController, co2Gear);
    final bikeKg = calculateKg(bikeController, co2Bike);
    final polyesterKg = calculateKg(polyesterController, co2Polyester);
    final cottonKg = calculateKg(cottonController, co2Cotton);
    final jacketKg = calculateKg(jacketController, co2Jacket);
    final sockKg = calculateKg(sockController, co2Sock);
    final pantKg = calculateKg(pantController, co2Pant);
    final globeKg = calculateKg(globeController, co2Globe);
    final sportKg = calculateKg(sportController, co2Sport);
    final skiClothKg = calculateKg(skiClothController, co2SkiCloth);
    final swimKg = calculateKg(swimController, co2Swim);
    final smartKg = calculateKg(smartController, co2Smart);
    final tentKg = calculateKg(tentController, co2Tent);

    total.value = runningKg +
        skisKg +
        ropeKg +
        gearKg +
        bikeKg +
        polyesterKg +
        cottonKg +
        cottonKg +
        jacketKg +
        sockKg +
        pantKg +
        globeKg +
        sportKg +
        skiClothKg +
        swimKg +
        smartKg +
        tentKg;
  }

  double calculateKg(TextEditingController controller, double conversionValue) {
    final controllerValue = double.tryParse(controller.text) ?? 0.0;
    return controllerValue * conversionValue;
  }

  void updateButtonState() {
    if (total.value == 0.0 || total.value.isNaN) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
