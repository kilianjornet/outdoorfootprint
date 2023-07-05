import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OthersController extends GetxController {
  //TODO: Implement OthersController

  final count = 0.obs;
  var isEnable = true.obs;
  RxString dropdownValue = "1".obs;
  var total = 0.0.obs;
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
  final firstNameNode = FocusNode();
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
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

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
}
