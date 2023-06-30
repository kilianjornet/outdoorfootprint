import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/utils/color_manager.dart';

class VerifyOtpWidget {
  VerifyOtpWidget._();

  static Widget otpTextField({
    required int numberOfFields,
    required List<TextEditingController> otpControllers,
    required List<FocusNode> otpNodes,
    required var isEnable,
  }) {
    void nextField({
      required int index,
      required FocusNode focusNode,
    }) {
      if (index != numberOfFields - 1) {
        FocusScope.of(Get.context!).requestFocus(otpNodes[index + 1]);
      } else {
        focusNode.unfocus();
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        top: 50.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          numberOfFields,
          (index) => SizedBox(
            width: 60.w,
            child: TextFormField(
              controller: otpControllers[index],
              focusNode: otpNodes[index],
              cursorColor: ColorManager.button,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: GoogleFonts.oswald(
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                color: ColorManager.labelText,
              ),
              maxLength: 1,
              enableSuggestions: false,
              onChanged: (value) {
                if (value.isEmpty) {
                  bool allFieldsEmpty = true;
                  for (int i = 0; i < numberOfFields; i++) {
                    if (otpControllers[i].text.isNotEmpty) {
                      allFieldsEmpty = false;
                      break;
                    }
                  }
                  if (allFieldsEmpty) {
                    FocusScope.of(Get.context!).requestFocus(otpNodes[0]);
                  } else {
                    int lastNonEmptyIndex = -1;
                    for (int i = numberOfFields - 1; i >= 0; i--) {
                      if (otpControllers[i].text.isNotEmpty) {
                        lastNonEmptyIndex = i;
                        break;
                      }
                    }
                    FocusScope.of(Get.context!).requestFocus(
                      otpNodes[lastNonEmptyIndex],
                    );
                  }
                } else if (value.length == 1) {
                  nextField(
                    index: index,
                    focusNode: otpNodes[index],
                  );
                }
                if (otpControllers.any(
                  (element) => element.text.isEmpty,
                )) {
                  isEnable.value = false;
                } else {
                  isEnable.value = true;
                }
              },
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: ColorManager.white,
                counterText: '',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorManager.button,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.w,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.errorText,
                    width: 1.5.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.w,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorManager.white,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
