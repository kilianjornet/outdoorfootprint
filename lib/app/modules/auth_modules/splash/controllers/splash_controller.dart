import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/token_manager.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      animationController,
    );
    Future.delayed(
      const Duration(
        seconds: 4,
      ),
      () async {
        var token = await TokenManager.getAccessToken();
        if (token == null) {
          await Get.offAllNamed(
            '/sign-in',
          );
        } else {
          await Get.offAllNamed(
            '/navigation-bar',
          );
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
