import 'package:get/get.dart';

import '../../../../data/services/misc_services/privacy_policy_service.dart';
import '../../../../data/utils/widget_manager.dart';

class PrivacyPolicyController extends GetxController {
  final privacyPolicyService = PrivacyPolicyService();
  var content = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await privacyPolicy();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> privacyPolicy() async {
    try {
      WidgetManager.showCustomDialog();

      final privacyPolicyResponse = await privacyPolicyService.privacyPolicy();
      content.value = privacyPolicyResponse['cms']['content'];
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
