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
    initializeControllersWithDefaultValue();
  }

  @override
  void onClose() {
    disposeControllers();
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
    const conversions = {
      'running': 13.6,
      'skis': 45.2,
      'rope': 0.25,
      'gear': 12.0,
      'bike': 300.0,
      'polyester': 15.0,
      'cotton': 10.0,
      'jacket': 18.0,
      'sock': 1.9,
      'pant': 9.0,
      'globe': 2.0,
      'sport': 6.1,
      'skiCloth': 15.0,
      'swim': 1.8,
      'smart': 40.0,
      'tent': 13.0,
    };

    double calculateKg(TextEditingController controller, String key) {
      final controllerValue = double.tryParse(controller.text) ?? 0.0;
      return controllerValue * conversions[key]!;
    }

    final runningKg = calculateKg(runningController, 'running');
    final skisKg = calculateKg(skisController, 'skis');
    final ropeKg = calculateKg(ropeController, 'rope');
    final gearKg = calculateKg(gearController, 'gear');
    final bikeKg = calculateKg(bikeController, 'bike');
    final polyesterKg = calculateKg(polyesterController, 'polyester');
    final cottonKg = calculateKg(cottonController, 'cotton');
    final jacketKg = calculateKg(jacketController, 'jacket');
    final sockKg = calculateKg(sockController, 'sock');
    final pantKg = calculateKg(pantController, 'pant');
    final globeKg = calculateKg(globeController, 'globe');
    final sportKg = calculateKg(sportController, 'sport');
    final skiClothKg = calculateKg(skiClothController, 'skiCloth');
    final swimKg = calculateKg(swimController, 'swim');
    final smartKg = calculateKg(smartController, 'smart');
    final tentKg = calculateKg(tentController, 'tent');

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
    isEnable.value = total.value != 0.0 && !total.value.isNaN;
  }

  void initializeControllersWithDefaultValue() {
    final controllers = [
      runningController,
      skisController,
      ropeController,
      gearController,
      bikeController,
      polyesterController,
      cottonController,
      jacketController,
      sockController,
      pantController,
      globeController,
      sportController,
      skiClothController,
      swimController,
      smartController,
      tentController,
    ];

    for (var controller in controllers) {
      controller.text = '0';
    }
  }

  void disposeControllers() {
    final controllers = [
      runningController,
      skisController,
      ropeController,
      gearController,
      bikeController,
      polyesterController,
      cottonController,
      jacketController,
      sockController,
      pantController,
      globeController,
      sportController,
      skiClothController,
      swimController,
      smartController,
      tentController,
    ];

    for (var controller in controllers) {
      controller.dispose();
    }
  }
}
