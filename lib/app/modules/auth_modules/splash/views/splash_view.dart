import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';

import '../../../../data/utils/color_manager.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        decoration: const BoxDecoration(
          color: ColorManager.primary,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 125.h,
              ),
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    parent: controller.animationController,
                    curve: Curves.easeIn,
                  ),
                ),
                child: SvgPicture.asset(
                  AssetManager.logoWT,
                  width: 250.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 60.h,
              ),
              child: SvgPicture.asset(
                AssetManager.splashLogo,
                height: 425.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
