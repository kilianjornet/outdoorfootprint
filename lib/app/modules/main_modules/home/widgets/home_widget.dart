import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/color_manager.dart';

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
}
