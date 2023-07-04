import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';

import '../../../../../data/utils/color_manager.dart';
import '../controllers/house_controller.dart';

class GasDialogView extends GetView<HouseController> {
  const GasDialogView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 3,
          sigmaX: 3,
        ),
        child: Container(
          height: 150.h,
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
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: ColorManager.labelText,
                        ),
                        children: [
                          const TextSpan(
                            text: StringManager.cubicMeter,
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(
                                2.0,
                                -10.0,
                              ), // Adjust the offset for proper positioning
                              child: Text(
                                '3',
                                style: GoogleFonts.oswald(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.labelText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.buildGasRadio(
                      unitTitle: StringManager.cubicMeter,
                      unitValue: controller.gasUnit,
                    ),
                  ],
                ),
              ),
              Divider(
                color: ColorManager.labelText.withOpacity(
                  0.25,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: ColorManager.labelText,
                        ),
                        children: [
                          const TextSpan(
                            text: StringManager.cubicFeet,
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(
                                2.0,
                                -10.0,
                              ), // Adjust the offset for proper positioning
                              child: Text(
                                '3',
                                style: GoogleFonts.oswald(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.labelText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.buildGasRadio(
                      unitTitle: StringManager.cubicFeet,
                      unitValue: controller.gasUnit,
                    ),
                  ],
                ),
              ),
              Divider(
                color: ColorManager.labelText.withOpacity(
                  0.25,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringManager.kwh,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: ColorManager.labelText,
                    ),
                  ),
                  controller.buildGasRadio(
                    unitTitle: StringManager.kwh,
                    unitValue: controller.gasUnit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
