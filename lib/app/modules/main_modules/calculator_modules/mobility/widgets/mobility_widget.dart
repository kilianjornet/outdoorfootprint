import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

import '../../../../../data/utils/asset_manager.dart';
import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../views/km_dialog_view.dart';
import '../views/unit_dialog_view.dart';

class MobilityWidget {
  MobilityWidget._();

  static Widget customFieldWithUnit({
    String? subtitle,
    var quantityUnit,
    var distanceUnit,
    void Function(int)? onSelectedItemChanged,
    required TextEditingController controller,
    required FocusNode node,
    required UnitType type,
    required void Function(String)? onChanged,
  }) {
    Widget text;
    Widget asset;
    MainAxisAlignment mainAxisAlignment;
    void Function()? onTap;

    switch (type) {
      case UnitType.perKm:
        text = Obx(() {
          return Text(
            quantityUnit.value,
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: ColorManager.white,
            ),
          );
        });
        asset = SvgPicture.asset(
          AssetManager.downArrow,
          width: 10.w,
        );
        mainAxisAlignment = MainAxisAlignment.spaceBetween;
        onTap = () async {
          Get.dialog(
            const UnitDialogView(),
            barrierDismissible: false,
            barrierColor: ColorManager.button.withOpacity(
              0.5,
            ),
          );
        };
        break;
      case UnitType.liter:
        text = Obx(() {
          return Text(
            distanceUnit.value,
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: ColorManager.white,
            ),
          );
        });
        asset = SvgPicture.asset(
          AssetManager.downArrow,
          width: 10.w,
        );
        mainAxisAlignment = MainAxisAlignment.spaceBetween;
        onTap = () async {
          Get.dialog(
            const KmDialogView(),
            barrierDismissible: false,
            barrierColor: ColorManager.button.withOpacity(
              0.5,
            ),
          );
        };
        break;
      case UnitType.hours:
        text = Text(
          StringManager.hours,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.white,
          ),
        );
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        onTap = () async {
          WidgetManager.showNumberPicker(
            controller: controller,
            type: DropdownType.plane,
            onSelectedItemChanged: onSelectedItemChanged,
          );
        };
        break;
      case UnitType.km:
        text = Text(
          StringManager.km,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.white,
          ),
        );
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case UnitType.hoursFlight:
        text = Text(
          StringManager.flightHours,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.white,
          ),
        );
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.h,
          ),
          child: subtitle != null
              ? Text(
                  subtitle,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: ColorManager.labelText,
                  ),
                )
              : const SizedBox(),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 10.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onTapOutside: (value) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  onChanged: onChanged,
                  onTap: type == UnitType.hours ? onTap : null,
                  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'^0')),
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'^\d+\.?\d{0,2}',
                      ),
                    ),
                    // FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
                  ],
                  focusNode: node,
                  readOnly: type == UnitType.hours ? true : false,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorManager.secondaryField,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorManager.button,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          10.w,
                        ),
                        bottomLeft: Radius.circular(
                          10.w,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorManager.white,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          10.w,
                        ),
                        bottomLeft: Radius.circular(
                          10.w,
                        ),
                      ),
                    ),
                    suffixIcon: type == UnitType.hours
                        ? Container(
                            padding: EdgeInsets.only(
                              top: 19.h,
                              left: 10.w,
                              right: 15.w,
                              bottom: 17.h,
                            ),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: SvgPicture.asset(
                                AssetManager.arrowForward,
                                width: 7.w,
                              ),
                            ),
                          )
                        : null,
                  ),
                  style: GoogleFonts.oswald(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.labelText,
                  ),
                  cursorColor: ColorManager.cursor,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  width: type == UnitType.hours || type == UnitType.km
                      ? 75.w
                      : type == UnitType.hoursFlight
                          ? 100.w
                          : 140.w,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.5.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(
                          0.25,
                        ),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        10.w,
                      ),
                      bottomRight: Radius.circular(
                        10.w,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: mainAxisAlignment,
                    children: [
                      text,
                      asset,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum UnitType {
  perKm,
  liter,
  hours,
  km,
  hoursFlight,
}
