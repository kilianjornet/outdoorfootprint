import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/calculator_services/other_service.dart';

import '../../../../../data/utils/crud_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class OthersController extends GetxController {
  //TODO: Implement OthersController

  final count = 0.obs;
  var isEnable = true.obs;
  RxString dropdownValue = "1".obs;
  var total = 0.0.obs;
  var sum = 0.0.obs;

  final othersService=OtherService();
  final othersKey = GlobalKey<FormState>();
  final labelController1 = TextEditingController();
  final labelController2 = TextEditingController();
  final labelController3 = TextEditingController();
  final labelController4 = TextEditingController();
  final labelController5 = TextEditingController();
  final labelController6 = TextEditingController();
  final labelController7 = TextEditingController();
  final labelController8 = TextEditingController();
  final labelController9 = TextEditingController();
  final labelController10 = TextEditingController();
  final labelController11 = TextEditingController();
  final labelController12= TextEditingController();
  final labelController13= TextEditingController();
  final labelController14= TextEditingController();
  final labelController15= TextEditingController();
  final labelController16= TextEditingController();
  final labelControllerNode1 = FocusNode();
  final labelControllerNode2 = FocusNode();
  final labelControllerNode3 = FocusNode();
  final labelControllerNode4 = FocusNode();
  final labelControllerNode5 = FocusNode();
  final labelControllerNode6 = FocusNode();
  final labelControllerNode7 = FocusNode();
  final labelControllerNode8 = FocusNode();
  final labelControllerNode9 = FocusNode();
  final labelControllerNode10 = FocusNode();
  final labelControllerNode11= FocusNode();
  final labelControllerNode12= FocusNode();
  final labelControllerNode13= FocusNode();
  final labelControllerNode14= FocusNode();
  final labelControllerNode15= FocusNode();
  final labelControllerNode16= FocusNode();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    labelController1.text = '0';
    labelController2.text = '0';
    labelController3.text = '0';
    labelController4.text = '0';
    labelController5.text = '0';
    labelController6.text = '0';
    labelController7.text = '0';
    labelController8.text = '0';
    labelController9.text = '0';
    labelController10.text = '0';
    labelController11.text = '0';
    labelController12.text = '0';
    labelController13.text = '0';
    labelController14.text = '0';
    labelController15.text = '0';
    labelController16.text = '0';
  }

  @override
  void onClose() {
    super.onClose();
    labelController1.dispose();
    labelController2.dispose();
    labelController3.dispose();
    labelController4.dispose();
    labelController5.dispose();
    labelController6.dispose();
    labelController7.dispose();
    labelController8.dispose();
    labelController9.dispose();
    labelController10.dispose();
    labelController12.dispose();
    labelController13.dispose();
    labelController14.dispose();
    labelController15.dispose();
    labelController16.dispose();
  }

  void updateButtonState(dynamic value) {
    if (!othersKey.currentState!.validate() ||
        labelController1.text.isEmpty ||
        labelController2.text.isEmpty ||
        labelController3.text.isEmpty ||
        labelController4.text.isEmpty ||
        labelController5.text.isEmpty ||
        labelController6.text.isEmpty ||
        labelController7.text.isEmpty ||
        labelController8.text.isEmpty ||
        labelController9.text.isEmpty ||
        labelController10.text.isEmpty ||
        labelController11.text.isEmpty ||
        labelController12.text.isEmpty ||
        labelController13.text.isEmpty ||
        labelController14.text.isEmpty ||
        labelController15.text.isEmpty ||
        labelController16.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
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
    final labelValue1 = double.tryParse(labelController1.text) ?? 0.0;
    final labelValue2 = double.tryParse(labelController2.text) ?? 0.0;
    final labelValue3 = double.tryParse(labelController3.text) ?? 0.0;
    final labelValue4 = double.tryParse(labelController4.text) ?? 0.0;
    final labelValue5 = double.tryParse(labelController5.text) ?? 0.0;
    final labelValue6 = double.tryParse(labelController6.text) ?? 0.0;
    final labelValue7 = double.tryParse(labelController7.text) ?? 0.0;
    final labelValue8 = double.tryParse(labelController8.text) ?? 0.0;
    final labelValue9 = double.tryParse(labelController9.text) ?? 0.0;
    final labelValue10 = double.tryParse(labelController10.text) ?? 0.0;
    final labelValue11 = double.tryParse(labelController11.text) ?? 0.0;
    final labelValue12 = double.tryParse(labelController12.text) ?? 0.0;
    final labelValue13 = double.tryParse(labelController13.text) ?? 0.0;
    final labelValue14 = double.tryParse(labelController14.text) ?? 0.0;
    final labelValue15 = double.tryParse(labelController15.text) ?? 0.0;
    final labelValue16 = double.tryParse(labelController16.text) ?? 0.0;

    final labelValue1Kg = labelValue1 * 3.7;
    final labelValue2Kg = labelValue2 * 15;
    final labelValue3Kg = labelValue3 * 34;
    final labelValue4Kg = labelValue4 * 13.3;
    final labelValue5Kg = labelValue5 * 10;

    final labelValue6Kg = labelValue6 * 0.48;
    final labelValue7Kg = labelValue7 * 0.54;
    final labelValue8Kg = labelValue8 * 0.66;
    final labelValue9Kg = labelValue9 * 0.88;
    final labelValue10Kg = labelValue10 * 1.02;

    final labelValue11Kg = labelValue11 * 0.382;
    final labelValue12Kg = labelValue12 * 0.43;
    final labelValue13Kg = labelValue13 * 0.38;
    final labelValue14Kg = labelValue14 * 0.4698;
    final labelValue15Kg = labelValue15 * 0.139;
    final labelValue16Kg = labelValue16 * 0.234;

    total.value = labelValue1Kg +
        labelValue2Kg +
        labelValue3Kg +
        labelValue4Kg +
        labelValue5Kg +
        labelValue6Kg +
        labelValue7Kg +
        labelValue8Kg +
        labelValue9Kg +
        labelValue10Kg +
        labelValue11Kg +
        labelValue12Kg +
        labelValue13Kg +
        labelValue14Kg +
        labelValue15Kg +
        labelValue16Kg ;
  }

}
