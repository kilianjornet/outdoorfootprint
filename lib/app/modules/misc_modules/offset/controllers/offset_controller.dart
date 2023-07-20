import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/services/misc_services/offset_service.dart';

import '../../../../data/utils/widget_manager.dart';

class OffsetController extends GetxController {
  final offsetService = OffsetService();
  RxInt currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);
  var isEnable = true.obs;
  var removalContent = ''.obs;
  var removalAmount = ''.obs;
  var removalUrl = ''.obs;
  var reforestContent = ''.obs;
  var reforestAmount = ''.obs;
  var reforestUrl = ''.obs;
  var offsetQuestion = ''.obs;
  var offsetAnswer = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await offset();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> offset() async {
    try {
      WidgetManager.showCustomDialog();

      final offsetResponse = await offsetService.offset();
      final userTon = double.tryParse(offsetResponse['user_carbon_ton']);
      final allOffset = offsetResponse['all_offset'];

      // Offset for Removal
      final removalOffset = allOffset[1];
      removalContent.value = removalOffset['content'];
      final remAmount = double.tryParse(removalOffset['amount']) ?? 0.0;
      removalAmount.value = '${(userTon! * remAmount).round()}';
      removalUrl.value = removalOffset['url'];

      // Offset for Reforest
      final reforestOffset = allOffset[0];
      reforestContent.value = reforestOffset['content'];
      final refAmount = double.tryParse(reforestOffset['amount']) ?? 0.0;
      reforestAmount.value = '${(userTon * refAmount).round()}';
      reforestUrl.value = reforestOffset['url'];

      // Offset Question and Answer
      final offsetQnA = allOffset[2];
      offsetQuestion.value = offsetQnA['title'];
      offsetAnswer.value = offsetQnA['content'];
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
