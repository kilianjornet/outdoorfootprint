import 'package:get/get.dart';

import '../controllers/custom_dialog_controller.dart';

class CustomDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomDialogController>(
      () => CustomDialogController(),
    );
  }
}
