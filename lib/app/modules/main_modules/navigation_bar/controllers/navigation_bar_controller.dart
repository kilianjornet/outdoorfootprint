import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/crud_manager.dart';

import '../../../../data/services/main_services/profile_service.dart';
import '../../../../data/utils/widget_manager.dart';

class NavigationBarController extends GetxController {
  final profileService = ProfileService();
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await profile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> profile() async {
    try {
      WidgetManager.showCustomDialog();

      final profileResponse = await profileService.getProfile();
      await CrudManager.saveUserData(
        id: profileResponse['user']['id'],
        phoneNumber: profileResponse['user']['phoneNumber'],
        email: profileResponse['user']['email'],
        lastName: profileResponse['user']['lastName'],
        firstName: profileResponse['user']['firstName'],
        country: profileResponse['user']['address'],
        profileImage: profileResponse['user']['profile_image'],
      );
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
