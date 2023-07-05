import 'package:get/get.dart';

import '../controllers/gear_controller.dart';

class GearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GearController>(
      () => GearController(),
    );
  }
}
