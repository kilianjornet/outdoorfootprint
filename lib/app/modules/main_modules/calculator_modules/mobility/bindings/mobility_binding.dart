import 'package:get/get.dart';

import '../controllers/mobility_controller.dart';

class MobilityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobilityController>(
      () => MobilityController(),
    );
  }
}
