import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/calculator_services/other_service.dart';

import '../../../../../data/utils/crud_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class OthersController extends GetxController {
  final othersService = OtherService();

  final hotelController = TextEditingController();
  final scandinaviaController = TextEditingController();
  final usaController = TextEditingController();
  final alpsController = TextEditingController();
  final veganController = TextEditingController();
  final vegetarianController = TextEditingController();
  final lowController = TextEditingController();
  final mediumMeatController = TextEditingController();
  final heavyController = TextEditingController();
  final pharmaController = TextEditingController();
  final computerController = TextEditingController();
  final furnitureController = TextEditingController();
  final telephoneController = TextEditingController();
  final bankController = TextEditingController();
  final insuranceController = TextEditingController();
  final educationController = TextEditingController();
  final smallController = TextEditingController();
  final mediumCarController = TextEditingController();
  final bigController = TextEditingController();

  final hotelNode = FocusNode();
  final scandinaviaNode = FocusNode();
  final usaNode = FocusNode();
  final alpsNode = FocusNode();
  final veganNode = FocusNode();
  final vegetarianNode = FocusNode();
  final lowNode = FocusNode();
  final mediumMeatNode = FocusNode();
  final heavyNode = FocusNode();
  final pharmaNode = FocusNode();
  final computerNode = FocusNode();
  final furnitureNode = FocusNode();
  final telephoneNode = FocusNode();
  final bankNode = FocusNode();
  final insuranceNode = FocusNode();
  final educationNode = FocusNode();
  final smallNode = FocusNode();
  final mediumCarNode = FocusNode();
  final bigNode = FocusNode();

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

  Future<void> submitOthers() async {
    try {
      WidgetManager.showCustomDialog();

      final userId = await CrudManager.getId();
      final houseResponse = await othersService.submitOthers(
        userId: '$userId',
        totalKgCo2OfOthers: '${total.value}',
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
      'scandinavia': 3.7,
      'usa': 34.0,
      'alps': 13.3,
      'vegan': 0.48,
      'vegetarian': 0.54,
      'low_meat': 0.66,
      'medium_meat': 0.88,
      'heavy_meat': 1.02,
      'pharma': 0.382,
      'computer': 0.43,
      'furniture': 0.38,
      'telephone': 0.4698,
      'banking': 0.139,
      'insurance': 0.234,
      'education': 0.187,
      'small_car': 6000.0,
      'medium_car': 17000.0,
      'big_car': 35000.0,
    };

    double calculateKg(TextEditingController controller, String key) {
      final controllerValue = double.tryParse(controller.text) ?? 0.0;
      return controllerValue * conversions[key]!;
    }

    final hotelKg = double.tryParse(hotelController.text) ?? 0.0;
    final scandinaviaKg = calculateKg(scandinaviaController, 'scandinavia');
    final usaKg = calculateKg(usaController, 'usa');
    final alpsKg = calculateKg(alpsController, 'alps');
    final veganKg = calculateKg(veganController, 'vegan');
    final vegetarianKg = calculateKg(vegetarianController, 'vegetarian');
    final lowKg = calculateKg(lowController, 'low_meat');
    final mediumMeatKg = calculateKg(mediumMeatController, 'medium_meat');
    final heavyKg = calculateKg(heavyController, 'heavy_meat');
    final pharmaKg = calculateKg(pharmaController, 'pharma');
    final computerKg = calculateKg(computerController, 'computer');
    final furnitureKg = calculateKg(furnitureController, 'furniture');
    final telephoneKg = calculateKg(telephoneController, 'telephone');
    final bankKg = calculateKg(bankController, 'banking');
    final insuranceKg = calculateKg(insuranceController, 'insurance');
    final educationKg = calculateKg(educationController, 'education');
    final smallKg = calculateKg(smallController, 'small_car');
    final mediumCarKg = calculateKg(mediumCarController, 'medium_car');
    final bigKg = calculateKg(bigController, 'big_car');

    total.value = hotelKg +
        scandinaviaKg +
        usaKg +
        alpsKg +
        veganKg +
        vegetarianKg +
        lowKg +
        mediumMeatKg +
        heavyKg +
        pharmaKg +
        computerKg +
        furnitureKg +
        telephoneKg +
        bankKg +
        insuranceKg +
        educationKg +
        smallKg +
        mediumCarKg +
        bigKg;
  }

  void updateButtonState() {
    isEnable.value = total.value != 0.0 && !total.value.isNaN;
  }

  void initializeControllersWithDefaultValue() {
    final controllers = [
      hotelController,
      scandinaviaController,
      usaController,
      alpsController,
      veganController,
      vegetarianController,
      lowController,
      mediumMeatController,
      heavyController,
      pharmaController,
      computerController,
      furnitureController,
      telephoneController,
      bankController,
      insuranceController,
      educationController,
      smallController,
      mediumCarController,
      bigController,
    ];

    for (var controller in controllers) {
      controller.text = '0';
    }
  }

  void disposeControllers() {
    final controllers = [
      hotelController,
      scandinaviaController,
      usaController,
      alpsController,
      veganController,
      vegetarianController,
      lowController,
      mediumMeatController,
      heavyController,
      pharmaController,
      computerController,
      furnitureController,
      telephoneController,
      bankController,
      insuranceController,
      educationController,
      smallController,
      mediumCarController,
      bigController,
    ];

    for (var controller in controllers) {
      controller.dispose();
    }
  }
}
