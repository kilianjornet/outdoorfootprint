import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'asset_manager.dart';
import 'color_manager.dart';

class WidgetManager {
  WidgetManager._();

  static ScaffoldMessengerState customSnackBar({
    required String title,
    required SnackBarType type,
  }) {
    Color backgroundColor;
    Color primaryColor;
    String assetPath;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = ColorManager.snackBarSB;
        primaryColor = ColorManager.successText;
        assetPath = AssetManager.successSnackBar;
        break;
      case SnackBarType.info:
        backgroundColor = ColorManager.snackBarIB;
        primaryColor = ColorManager.infoText;
        assetPath = AssetManager.infoSnackBar;
        break;
      case SnackBarType.error:
        backgroundColor = ColorManager.snackBarEB;
        primaryColor = ColorManager.errorText;
        assetPath = AssetManager.errorSnackBar;
        break;
      case SnackBarType.notification:
        backgroundColor = ColorManager.snackBarNB;
        primaryColor = ColorManager.notificationText;
        assetPath = AssetManager.notificationSnackBar;
        break;
    }

    return ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          margin: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 16.h,
            ),
            margin: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              bottom: 10.h,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.5),
                  blurRadius: 6,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(
                8.w,
              ),
              border: Border.all(
                color: primaryColor,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  assetPath,
                  width: 25.w,
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 6.w,
                    ),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(
            seconds: 5,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

enum SnackBarType {
  success,
  info,
  error,
  notification,
}
