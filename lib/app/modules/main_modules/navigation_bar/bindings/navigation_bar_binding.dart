import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/my_footprint/controllers/my_footprint_controller.dart';

import '../../calculator_modules/add/controllers/add_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/navigation_bar_controller.dart';

class NavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationBarController>(
      () => NavigationBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AddController>(
      () => AddController(),
    );
    Get.lazyPut<MyFootprintController>(
      () => MyFootprintController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
