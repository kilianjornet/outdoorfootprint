import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/color_manager.dart';

class GearWidget {
  GearWidget._();

  static Widget textWithField({
    required String? fieldName,
    required var isEnable,
    required String? dropdownvalue,
  }) {
    var isPressed = false.obs;
    return GestureDetector(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                fieldName!,
                style: GoogleFonts.oswald(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.labelText,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorManager
                      .dropdownColor, //background color of dropdown button
                  border: Border.all(
                      color: ColorManager.dropdownColor,
                      width: 3), //border of dropdown button
                  borderRadius: BorderRadius.circular(
                      8), //border raiuds of dropdown button
                ),
                child: DropdownButton<String>(
                  value: dropdownvalue,
                  hint: null,
                  isExpanded: true,
                  items: <String>[
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          value,
                          style: GoogleFonts.oswald(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.labelText,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    //get value when changed
                    if (kDebugMode) {
                      print("You selected $value");
                    }
                  },
                  icon: const Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_drop_down)),
                  iconEnabledColor: ColorManager.labelText, //Icon color
                  style: GoogleFonts.oswald(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.labelText,
                  ),
                  dropdownColor: ColorManager.white, //dropdown background color
                )),
          )
        ],
      ),
    );
  }
}
