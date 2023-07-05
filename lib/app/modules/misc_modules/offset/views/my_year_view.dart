import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/modules/misc_modules/offset/controllers/offset_controller.dart';
import 'package:my_outdoor_footprint/app/modules/misc_modules/offset/widgets/offset_widget.dart';

class MyYearView extends GetView<OffsetController> {
  const MyYearView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          OffsetWidget.titleCanvasButton(
            type: OffsetType.removal,
            isEnable: controller.isEnable,
          ),
          OffsetWidget.titleCanvasButton(
            type: OffsetType.reforest,
            isEnable: controller.isEnable,
          ),
          OffsetWidget.canvasQA(
            title: controller.map['title'],
            content: controller.map['content'],
          ),
        ],
      ),
    );
  }
}
