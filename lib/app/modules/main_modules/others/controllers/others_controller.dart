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
        labelController5.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
