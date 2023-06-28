import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';

class SignUpController extends GetxController {
  final signUpKey = GlobalKey<FormState>();
  FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final emailNode = FocusNode();
  final countryNode = FocusNode();
  final numberNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  var country = ''.obs;
  var obscurePasswordText = true.obs;
  var obscureConfirmPasswordText = true.obs;
  var isChecked = false.obs;
  var isEnable = false.obs;
  @override
  void onInit() {
    super.onInit();
    countryPicker = FlCountryCodePicker(
      localize: false,
      showDialCode: false,
      title: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 15.h,
        ),
        child: Text(
          StringManager.selectCountry,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.subtitleText,
          ),
        ),
      ),
      countryTextStyle: GoogleFonts.oswald(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: ColorManager.white,
      ),
      searchBarDecoration: InputDecoration(
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
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateButtonState(String value) {
    if (!signUpKey.currentState!.validate() ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        countryController.text.isEmpty ||
        numberController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      isEnable.value = false;
    } else {
      isEnable.value = true;
    }
  }
}
