import 'package:get/get.dart';

class MyFootprintController extends GetxController {
  //TODO: Implement MyFootprintController

  final count = 0.obs;
  var totalKg = '1922.216';
  var totalTon = '1.73613';
  List<double> dataPoints = [40, 30, 15, 15];
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
