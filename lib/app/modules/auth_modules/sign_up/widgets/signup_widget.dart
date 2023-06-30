import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/validation_manager.dart';

class SignUpWidget {
  SignUpWidget._();

  static Widget nameTextField({
    required TextEditingController nameController,
    required FocusNode nameNode,
    required String? hintText,
    required String? errorText,
    required void Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: TextFormField(
        onTapOutside: (value) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onChanged: onChanged,
        controller: nameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.name,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(
              "[a-zA-Z]",
            ),
          ),
          TextInputFormatter.withFunction(
            (oldValue, newValue) {
              if (newValue.text.isNotEmpty) {
                return TextEditingValue(
                  text: newValue.text.substring(0, 1).toUpperCase() +
                      newValue.text.substring(1),
                  selection: newValue.selection,
                );
              }
              return newValue;
            },
          ),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return null;
          }
          if (!ValidationManager.validateName(value)) {
            return errorText;
          }
          return null;
        },
        focusNode: nameNode,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: ColorManager.white,
          hintText: hintText,
          hintStyle: GoogleFonts.oswald(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.labelText,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.button,
              width: 1.5.w,
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
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.errorText,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          errorStyle: GoogleFonts.oswald(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.errorText,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 15.w,
              right: 10.w,
              bottom: 12.h,
            ),
            child: SvgPicture.asset(
              AssetManager.user,
              width: 7.w,
            ),
          ),
        ),
        style: GoogleFonts.oswald(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorManager.labelText,
        ),
        cursorColor: ColorManager.cursor,
      ),
    );
  }

  static Widget countryTextField({
    required TextEditingController countryController,
    required FocusNode countryNode,
    required void Function(String)? onChanged,
    required void Function()? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: TextFormField(
        onTapOutside: (value) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onChanged: onChanged,
        onTap: onTap,
        readOnly: true,
        controller: countryController,
        focusNode: countryNode,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: ColorManager.white,
          hintText: StringManager.country,
          hintStyle: GoogleFonts.oswald(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.labelText,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.button,
              width: 1.5.w,
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
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.errorText,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          errorStyle: GoogleFonts.oswald(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.errorText,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 15.w,
              right: 10.w,
              bottom: 12.h,
            ),
            child: SvgPicture.asset(
              AssetManager.world,
              width: 7.w,
            ),
          ),
        ),
        style: GoogleFonts.oswald(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorManager.labelText,
        ),
        cursorColor: ColorManager.button,
      ),
    );
  }

  static Widget numberTextField({
    required TextEditingController numberController,
    required FocusNode numberNode,
    required void Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: TextFormField(
        onTapOutside: (value) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onChanged: onChanged,
        controller: numberController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return null;
          }
          if (!ValidationManager.validateNumber(value)) {
            return StringManager.enterValidPhoneNumber;
          }
          return null;
        },
        focusNode: numberNode,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: ColorManager.white,
          hintText: StringManager.phoneNumber,
          hintStyle: GoogleFonts.oswald(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.labelText,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.button,
              width: 1.5.w,
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
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.errorText,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          errorStyle: GoogleFonts.oswald(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.errorText,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 15.w,
              right: 10.w,
              bottom: 12.h,
            ),
            child: SvgPicture.asset(
              AssetManager.mobile,
              width: 7.w,
            ),
          ),
        ),
        style: GoogleFonts.oswald(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorManager.labelText,
        ),
        cursorColor: ColorManager.button,
      ),
    );
  }

  static Widget agreeTermsAndPrivacy({
    required var isChecked,
    required void Function(bool?)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 20.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Transform.scale(
              scale: 1.25,
              child: Checkbox(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                value: isChecked.value,
                onChanged: onChanged,
                activeColor: ColorManager.white,
                checkColor: ColorManager.labelText,
                side: BorderSide(
                  color: ColorManager.white,
                  width: 1.5.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    3.w,
                  ),
                ),
              ),
            );
          }),
          Padding(
            padding: EdgeInsets.only(
              left: 10.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${StringManager.agreeTo} ',
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: ColorManager.white,
                      ),
                    ),
                    Text(
                      StringManager.termsAndConditions,
                      style: GoogleFonts.oswald(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: ColorManager.white,
                      ),
                    ),
                    Text(
                      ' ${StringManager.andThe}',
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  StringManager.privacyPolicy,
                  style: GoogleFonts.oswald(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
