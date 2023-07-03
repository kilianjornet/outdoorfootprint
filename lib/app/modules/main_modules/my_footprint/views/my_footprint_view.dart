import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/widget_manager.dart';
import '../controllers/my_footprint_controller.dart';

class MyFootprintView extends GetView<MyFootprintController> {
  const MyFootprintView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: WidgetManager.primaryAppBar(
          title: StringManager.myFootprint,
          type: AppBarType.primary,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
          ),
        )
    );
  }
}
