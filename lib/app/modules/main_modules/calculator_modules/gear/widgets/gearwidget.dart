import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

import '../../../../../data/utils/asset_manager.dart';
import '../../../../../data/utils/color_manager.dart';

class GearWidget {
  GearWidget._();

  static Widget customFieldWithUnit({
    required String subtitle,
    required void Function(int)? onSelectedItemChanged,
    required TextEditingController controller,
    required FocusNode node,
    required void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.h,
          ),
          child: Text(
            subtitle,
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: ColorManager.labelText,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 10.h,
          ),
          child: TextFormField(
            onTapOutside: (value) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            onChanged: onChanged,
            onTap: () async {
              WidgetManager.showNumberPicker(
                controller: controller,
                type: DropdownType.plane,
                onSelectedItemChanged: onSelectedItemChanged,
              );
            },
            controller: controller,
            focusNode: node,
            readOnly: true,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: ColorManager.secondaryField,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorManager.button,
                ),
                borderRadius: BorderRadius.all(Radius.circular(
                  10.w,
                )),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorManager.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(
                  10.w,
                )),
              ),
              suffixIcon: Container(
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
      ],
    );
  }
}
