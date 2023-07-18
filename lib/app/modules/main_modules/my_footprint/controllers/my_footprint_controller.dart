import 'package:get/get.dart';

class MyFootprintController extends GetxController {
  //TODO: Implement MyFootprintController

  final count = 0.obs;
  var totalKg = '1922.216';
  var totalTon = '1.73613';
  List<double> dataPoints = [40, 30, 15, 15];
  var co2Home = 0.0.obs;
  var co2Mobility = 0.0.obs;
  var co2Gear = 0.0.obs;
  var co2Food = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    co2Home.value = 20.0;
    co2Mobility.value = 35.0;
    co2Gear.value = 25.0;
    co2Food.value = 20.0;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
