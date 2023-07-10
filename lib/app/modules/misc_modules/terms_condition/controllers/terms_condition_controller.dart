import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/misc_services/terms_condition_service.dart';

import '../../../../data/utils/widget_manager.dart';

class TermsConditionController extends GetxController {
  final termsConditionService = TermsConditionService();
  var content = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await termsCondition();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> termsCondition() async {
    try {
      WidgetManager.showCustomDialog();

      final termsConditionResponse =
          await termsConditionService.termsCondition();
      content.value = termsConditionResponse['cms']['content'];
    } catch (e) {
      WidgetManager.customSnackBar(
        title: '$e',
        type: SnackBarType.error,
      );
    } finally {
      WidgetManager.hideCustomDialog();
    }
  }
}
