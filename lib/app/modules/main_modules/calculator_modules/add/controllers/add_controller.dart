import 'package:get/get.dart';

class AddController extends GetxController {
  //TODO: Implement AddController

  final count = 0.obs;
  var isEnable = true.obs;
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
}
