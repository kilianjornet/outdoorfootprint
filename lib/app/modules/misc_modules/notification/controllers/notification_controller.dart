import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/misc_services/notification_service.dart';

import '../../../../data/utils/widget_manager.dart';

class NotificationController extends GetxController {
  final notificationService = NotificationService();
  dynamic list = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await notification();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> notification() async {
    try {
      WidgetManager.showCustomDialog();

      final notificationResponse = await notificationService.notification();
      list.value = notificationResponse['all_notification'];
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
