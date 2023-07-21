import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/main_services/my_footprint_service.dart';

import '../../../../data/utils/widget_manager.dart';

class MyFootprintController extends GetxController {
  final myFootprintService = MyFootprintService();
  late dynamic list = [].obs;
  var maxTotalKg = 0.00.obs;
  var totalKg = 0.00.obs;
  var totalTon = 0.00.obs;
  var co2Home = 0.00.obs;
  var co2Mobility = 0.00.obs;
  var co2Gear = 0.00.obs;
  var co2Food = 0.00.obs;
  var co2Public = 0.00.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getUserFootprint();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUserFootprint() async {
    try {
      WidgetManager.showCustomDialog();

      final myFootprintResponse = await myFootprintService.getUserFootprint();
      list.value = myFootprintResponse['fourYearData'];
      co2Home.value = double.tryParse(
          '${myFootprintResponse['fourYearData'][0]['calculation']['totalKgCo2OfHome']}')!;
      co2Mobility.value = double.tryParse(
          '${myFootprintResponse['fourYearData'][0]['calculation']['totalKgCo2OfMobility']}')!;
      co2Gear.value = double.tryParse(
          '${myFootprintResponse['fourYearData'][0]['calculation']['totalKgCo2OfGear']}')!;
      co2Food.value = double.tryParse(
          '${myFootprintResponse['fourYearData'][0]['calculation']['totalKgCo2OfOthers']}')!;
      co2Public.value = double.tryParse(
          '${myFootprintResponse['fourYearData'][0]['calculation']['totalKgCo2OfPublicServiceShare']}')!;
      totalKg.value = double.tryParse(
          '${myFootprintResponse['fourYearData'][0]['calculation']['totalKgOfCo2']}')!;
      totalTon.value = double.tryParse(
          '${myFootprintResponse['fourYearData'][0]['calculation']['totalTonsOfCo2']}')!;

      double maxKg = 0.0;
      for (var data in myFootprintResponse['fourYearData']) {
        double totalKg =
            double.tryParse('${data['calculation']['totalKgOfCo2']}') ?? 0.0;
        if (totalKg > maxKg) {
          maxKg = totalKg;
        }
      }
      maxTotalKg.value = maxKg;
      print(maxTotalKg);
    } catch (e) {
      WidgetManager.customSnackBar(
        title: '$e',
        type: SnackBarType.error,
      );
    } finally {
      WidgetManager.hideCustomDialog();
      isLoading.value = true;
    }
  }
}
