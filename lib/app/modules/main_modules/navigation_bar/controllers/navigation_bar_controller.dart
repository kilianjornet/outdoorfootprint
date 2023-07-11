import 'package:get/get.dart';

import '../../../../data/services/main_services/profile_service.dart';

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
  }

  @override
  void onClose() {
    super.onClose();
  }
}
