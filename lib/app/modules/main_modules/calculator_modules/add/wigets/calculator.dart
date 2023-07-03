import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/utils/asset_manager.dart';
import '../../../../../data/utils/color_manager.dart';

class CalculatorWidget{
  CalculatorWidget._();
  static Widget calculatorPageButton1({
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
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 16.h,
            // bottom: 20.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? ColorManager.buttonPressed
                : isEnable.value
                ? ColorManager.white
                : ColorManager.white,
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            boxShadow: isEnable.value
                ? [
              BoxShadow(
                color: ColorManager.button.withOpacity(
                  0.2,
                ),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: SvgPicture.asset(
                      AssetManager.homeE,
                      width: 20.w,
                      // height: 26.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonName!,
                      style: GoogleFonts.oswald(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.labelText,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SvgPicture.asset(
                  AssetManager.arrowForward,
                  width: 26.w,
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget calculatorPageButton2({
    required String? buttonName,
    required var isEnable,
    required void Function()? onTap,
  })  {
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
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 8.h,
            // bottom: 20.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? ColorManager.buttonPressed
                : isEnable.value
                ? ColorManager.white
                : ColorManager.white,
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            boxShadow: isEnable.value
                ? [
              BoxShadow(
                color: ColorManager.button.withOpacity(
                  0.2,
                ),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: SvgPicture.asset(
                      AssetManager.mobile,
                      width: 20.w,
                      // height: 26.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonName!,
                      style: GoogleFonts.oswald(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.labelText,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SvgPicture.asset(
                  AssetManager.arrowForward,
                  width: 26.w,
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget calculatorPageButton3({
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
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 8.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? ColorManager.buttonPressed
                : isEnable.value
                ? ColorManager.white
                : ColorManager.white,
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            boxShadow: isEnable.value
                ? [
              BoxShadow(
                color: ColorManager.button.withOpacity(
                  0.2,
                ),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: SvgPicture.asset(
                      AssetManager.gear,
                      width: 20.w,
                      // height: 26.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonName!,
                      style: GoogleFonts.oswald(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.labelText,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SvgPicture.asset(
                  AssetManager.arrowForward,
                  width: 26.w,
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget calculatorPageButton4({
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
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 8.h,
            //bottom: 20.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? ColorManager.buttonPressed
                : isEnable.value
                ? ColorManager.white
                : ColorManager.white,
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            boxShadow: isEnable.value
                ? [
              BoxShadow(
                color: ColorManager.button.withOpacity(
                  0.2,
                ),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: SvgPicture.asset(
                      AssetManager.food,
                      width: 20.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonName!,
                      style: GoogleFonts.oswald(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.labelText,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SvgPicture.asset(
                  AssetManager.arrowForward,
                  width: 26.w,
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget calculatorPageButton5({
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
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 8.h,
            //bottom: 20.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? ColorManager.buttonPressed
                : isEnable.value
                ? ColorManager.white
                : ColorManager.white,
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            boxShadow: isEnable.value
                ? [
              BoxShadow(
                color: ColorManager.button.withOpacity(
                  0.2,
                ),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: SvgPicture.asset(
                      AssetManager.publicService,
                      width: 20.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonName!,
                      style: GoogleFonts.oswald(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.labelText,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SvgPicture.asset(
                  AssetManager.arrowForward,
                  width: 26.w,
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

