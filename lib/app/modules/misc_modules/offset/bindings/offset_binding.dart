import 'package:get/get.dart';

import '../controllers/offset_controller.dart';

class OffsetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OffsetController>(
      () => OffsetController(),
    );
  }
}
