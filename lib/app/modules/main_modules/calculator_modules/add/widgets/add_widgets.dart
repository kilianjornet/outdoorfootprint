import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';

import '../../../../../data/utils/asset_manager.dart';
import '../../../../../data/utils/color_manager.dart';

class AddWidget {
  AddWidget._();

  static Widget category({
    required CategoryType type,
  }) {
    void Function()? onTap;
    String assetPath;
    String title;
    var isPressed = false.obs;

    switch (type) {
      case CategoryType.home:
        assetPath = AssetManager.home;
        title = StringManager.home;
        onTap = () async {
          await Get.toNamed(
            '/house',
          );
        };
        break;
      case CategoryType.mobility:
        assetPath = AssetManager.car;
        title = StringManager.mobility;
        onTap = () async {
          await Get.toNamed(
            '/mobility',
          );
        };
        break;
      case CategoryType.gear:
        assetPath = AssetManager.gear;
        title = StringManager.gear;
        onTap = () async {
          await Get.toNamed(
            '/gear',
          );
        };
        break;
      case CategoryType.food:
        assetPath = AssetManager.food;
        title = StringManager.calculatorCat4;
        onTap = () async {
          await Get.toNamed(
            '/others',
          );
        };
        break;
      case CategoryType.public:
        assetPath = AssetManager.publicService;
        title = StringManager.calculatorCat5;
        onTap = () async {};
        break;
    }

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
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: type == CategoryType.home ? 16.h : 10.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? ColorManager.dropdownColor
                : ColorManager.white,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25.w,
                      right: 14.w,
                    ),
                    child: SvgPicture.asset(
                      assetPath,
                      width: 16.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
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
                padding: EdgeInsets.only(
                  right: 25.w,
                ),
                child: SvgPicture.asset(
                  AssetManager.arrowForward,
                  height: 10.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum CategoryType {
  home,
  mobility,
  gear,
  food,
  public,
}
