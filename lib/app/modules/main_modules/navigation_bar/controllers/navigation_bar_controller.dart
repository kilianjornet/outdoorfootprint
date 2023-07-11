import 'package:get/get.dart';

import '../../../../data/services/main_services/profile_service.dart';
import '../../calculator_modules/add/controllers/add_controller.dart';
import '../../calculator_modules/add/views/add_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';
import '../../my_footprint/controllers/my_footprint_controller.dart';
import '../../my_footprint/views/my_footprint_view.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../profile/views/profile_view.dart';

class NavigationBarController extends GetxController {
  final profileService = ProfileService();
  var selectedIndex = 0.obs;
  var bottomPages = const [
    HomeView(),
    AddView(),
    MyFootprintView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
    initializeController(selectedIndex.value);
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    closeController(selectedIndex.value);
    super.onClose();
  }

  void initializeController(int index) {
    switch (index) {
      case 0:
        Get.put(HomeController());
        break;
      case 1:
        Get.put(AddController());
        break;
      case 2:
        Get.put(MyFootprintController());
        break;
      case 3:
        Get.put(ProfileController());
        break;
    }
  }

  void closeController(int index) {
    switch (index) {
      case 0:
        Get.delete<HomeController>();
        break;
      case 1:
        Get.delete<AddController>();
        break;
      case 2:
        Get.delete<MyFootprintController>();
        break;
      case 3:
        Get.delete<ProfileController>();
        break;
    }
  }

  void openController(int index) {
    if (selectedIndex.value == index) {
      return;
    }
    closeController(selectedIndex.value);
    selectedIndex.value = index;
    initializeController(selectedIndex.value);
  }
}
