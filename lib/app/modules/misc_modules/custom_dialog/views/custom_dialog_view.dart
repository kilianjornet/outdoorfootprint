import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../data/utils/asset_manager.dart';
import '../controllers/custom_dialog_controller.dart';

class CustomDialogView extends GetView {
  CustomDialogView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(CustomDialogController());
  @override
  Widget build(
    BuildContext context,
  ) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 3,
        sigmaX: 3,
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (
            context,
            child,
          ) {
            return Transform.scale(
              scale: 1.0 - controller.animationController.value * 0.1,
              child: SvgPicture.asset(
                AssetManager.logo,
                width: 75.w,
              ),
            );
          },
        ),
      ),
    );
  }
}
