import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/house/views/oil_dialog_view.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../views/gas_dialog_view.dart';

class HouseWidget {
  HouseWidget._();

  static Widget customFieldWithUnit({
    String? title,
    String? subtitle,
    var gasUnit,
    var oilUnit,
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
      case UnitType.cubicMeter:
        text = Obx(() {
          return RichText(
            text: TextSpan(
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: ColorManager.white,
              ),
              children: [
                TextSpan(
                  text: gasUnit.value,
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
                        fontSize: gasUnit != StringManager.kwh ? 12.sp : 0,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
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
            const GasDialogView(),
            barrierDismissible: false,
            barrierColor: ColorManager.button.withOpacity(
              0.5,
            ),
          );
        };
        break;
      case UnitType.kgCoal:
        text = Text(
          StringManager.kgCoal,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.white,
          ),
        );
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case UnitType.kg:
        text = Text(
          StringManager.kg,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.white,
          ),
        );
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case UnitType.litres:
        text = Obx(() {
          return Text(
            oilUnit.value,
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
            const OilDialogView(),
            barrierDismissible: false,
            barrierColor: ColorManager.button.withOpacity(
              0.5,
            ),
          );
        };
        break;
      case UnitType.kwh:
        text = Text(
          StringManager.kwh,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.white,
          ),
        );
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case UnitType.gb:
        text = Text(
          StringManager.gbUse,
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
        title != null
            ? Text(
                title,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: ColorManager.displayText,
                ),
              )
            : const SizedBox(),
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
                  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'^0')),
                    // FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'^\d+\.?\d{0,2}',
                      ),
                    ),
                  ],
                  focusNode: node,
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
                  width: type == UnitType.kwh ? 50.w : 75.w,
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
  cubicMeter,
  kgCoal,
  kg,
  litres,
  kwh,
  gb,
}
