import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../controllers/mobility_controller.dart';

class UnitDialogView extends GetView<MobilityController> {
  const UnitDialogView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 3,
          sigmaX: 3,
        ),
        child: Container(
          height: 100.h,
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(
              10.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  controller.selectQuantityUnit(
                    StringManager.literPerKm,
                  );
                  controller.calculateTotalCarbon();
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringManager.literPerKm,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: ColorManager.labelText,
                      ),
                    ),
                    controller.buildQuantityRadio(
                      unitTitle: StringManager.literPerKm,
                      unitValue: controller.quantityUnit,
                    ),
                  ],
                ),
              ),
              Divider(
                color: ColorManager.labelText.withOpacity(
                  0.25,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  controller.selectQuantityUnit(
                    StringManager.milesPerGallon,
                  );
                  controller.calculateTotalCarbon();
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringManager.milesPerGallon,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: ColorManager.labelText,
                      ),
                    ),
                    controller.buildQuantityRadio(
                      unitTitle: StringManager.milesPerGallon,
                      unitValue: controller.quantityUnit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
