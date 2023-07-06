import 'package:get/get.dart';

class HomeController extends GetxController {
  var totalKg = '1736.13';
  var totalTon = '1.73613';
  List<double> dataPoints = [40, 30, 15, 15];
  List<RxBool> isEnable = List.generate(2, (index) => true.obs);

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

  double getTotalValue() {
    return dataPoints.fold(0, (previous, current) => previous + current);
  }
}
