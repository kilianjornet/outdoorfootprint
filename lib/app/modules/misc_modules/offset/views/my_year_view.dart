import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/modules/misc_modules/offset/controllers/offset_controller.dart';
import 'package:my_outdoor_footprint/app/modules/misc_modules/offset/widgets/offset_widget.dart';

class MyYearView extends GetView<OffsetController> {
  const MyYearView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: Column(
          children: [
            OffsetWidget.titleCanvasButton(
              type: OffsetType.removal,
              content: controller.removalContent,
              amount: controller.removalAmount,
              url: controller.removalUrl,
              isEnable: controller.isEnable,
            ),
            OffsetWidget.titleCanvasButton(
              type: OffsetType.reforest,
              content: controller.reforestContent,
              amount: controller.reforestAmount,
              url: controller.reforestUrl,
              isEnable: controller.isEnable,
            ),
            OffsetWidget.canvasQA(
              title: controller.offsetQuestion,
              content: controller.offsetAnswer,
            ),
          ],
        ),
      ),
    );
  }
}
