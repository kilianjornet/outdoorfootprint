import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/misc_services/tips_service.dart';

import '../../../../data/utils/widget_manager.dart';

class TipsController extends GetxController {
  final tipsService = TipsService();
  dynamic list = [].obs;
  var tipsTitle = ''.obs;
  late List<RxBool> boolList = List.generate(list.length, (index) => false.obs);
  late List<RxBool> isPressed =
      List.generate(list.length, (index) => false.obs);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await tips();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> tips() async {
    try {
      WidgetManager.showCustomDialog();

      final tipsResponse = await tipsService.tips();
      tipsTitle.value = tipsResponse['allTips'][0]['tips_title'];
      list.value = tipsResponse['allTips'][0]['content'];
    } catch (e) {
      WidgetManager.customSnackBar(
        title: '$e',
        type: SnackBarType.error,
      );
    } finally {
      WidgetManager.hideCustomDialog();
    }
  }

  void toggleExpand(int index) {
    boolList[index].value = !boolList[index].value;
  }
}
