import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';

class HomeWidget {
  HomeWidget._();

  static Widget primaryButton({
    required String? buttonName,
    required var isEnable,
    required void Function()? onTap,
  }) {
    var isPressed = false.obs;
    return Obx(
      () => GestureDetector(
        onTapDown: (value) {
          if (isEnable.value == true) {
            isPressed.value = true;
          }
        },
        onTapUp: (value) {
          if (isEnable.value == true) {
            isPressed.value = false;
          }
        },
        onTap: isEnable.value ? onTap : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            margin: EdgeInsets.only(
              bottom: 20.h,
            ),
            decoration: BoxDecoration(
              color: isPressed.value
                  ? ColorManager.buttonPressed
                  : isEnable.value
                      ? ColorManager.button
                      : ColorManager.button.withOpacity(
                          0.4,
                        ),
              borderRadius: BorderRadius.circular(
                8.w,
              ),
              boxShadow: isEnable.value
                  ? [
                      BoxShadow(
                        color: ColorManager.button.withOpacity(
                          0.5,
                        ),
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ]
                  : null,
            ),
            child: Text(
              buttonName!,
              style: GoogleFonts.oswald(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget confirmationDialog({
    required DialogType type,
    required var openDialog,
    required void Function()? onTap,
  }) {
    String title;
    String subtitle;
    String assetPath;
    Color assetBackground;

    switch (type) {
      case DialogType.signOut:
        title = StringManager.signOutTitle;
        subtitle = StringManager.signOutSubtitle;
        assetPath = AssetManager.logout;
        assetBackground = ColorManager.snackBarNB;
        break;
      case DialogType.delete:
        title = StringManager.deleteTitle;
        subtitle = StringManager.deleteSubtitle;
        assetPath = AssetManager.delete;
        assetBackground = ColorManager.snackBarEB;
        break;
    }
    return WillPopScope(
      onWillPop: () async {
        openDialog.value = false;
        return true;
      },
      child: Dialog(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 3,
            sigmaX: 3,
          ),
          child: Container(
            height: 265.h,
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 10.h,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(
                10.w,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50.h,
                  width: 50.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  decoration: BoxDecoration(
                    color: assetBackground,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    assetPath,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  child: Text(
                    title,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: ColorManager.displayText,
                    ),
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: ColorManager.labelText,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    confirmationButton(
                      type: ConfirmationType.cancel,
                      onTap: () async {
                        Get.back();
                      },
                    ),
                    confirmationButton(
                      type: type == DialogType.delete
                          ? ConfirmationType.delete
                          : ConfirmationType.signOut,
                      onTap: onTap,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget confirmationButton({
    required ConfirmationType type,
    required void Function()? onTap,
  }) {
    String title;
    Color text;
    Color background;
    Color backgroundPressed;

    switch (type) {
      case ConfirmationType.cancel:
        title = StringManager.cancel;
        text = ColorManager.labelText;
        background = ColorManager.white;
        backgroundPressed = ColorManager.secondaryField;
        break;
      case ConfirmationType.signOut:
        title = StringManager.signOut;
        text = ColorManager.white;
        background = ColorManager.button;
        backgroundPressed = ColorManager.buttonPressed;
        break;
      case ConfirmationType.delete:
        title = StringManager.delete;
        text = ColorManager.white;
        background = ColorManager.errorText;
        backgroundPressed = ColorManager.deletePressed;
        break;
    }

    var isPressed = false.obs;
    return Obx(
      () => GestureDetector(
        onTapDown: (value) {
          isPressed.value = true;
        },
        onTapUp: (value) {
          isPressed.value = false;
        },
        onTap: onTap,
        child: Container(
          width: 120.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 35.h,
            bottom: 20.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value ? backgroundPressed : background,
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorManager.boxShadow.withOpacity(
                  0.3,
                ),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ],
          ),
          child: Text(
            title,
            style: GoogleFonts.oswald(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: text,
            ),
          ),
        ),
      ),
    );
  }
}

enum DialogType {
  signOut,
  delete,
}

enum ConfirmationType {
  cancel,
  delete,
  signOut,
}
