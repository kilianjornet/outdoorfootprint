import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/validation_manager.dart';

import 'asset_manager.dart';
import 'color_manager.dart';

class WidgetManager {
  WidgetManager._();

  static ScaffoldMessengerState customSnackBar({
    required String title,
    required SnackBarType type,
  }) {
    Color backgroundColor;
    Color primaryColor;
    String assetPath;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = ColorManager.snackBarSB;
        primaryColor = ColorManager.successText;
        assetPath = AssetManager.successSnackBar;
        break;
      case SnackBarType.info:
        backgroundColor = ColorManager.snackBarIB;
        primaryColor = ColorManager.infoText;
        assetPath = AssetManager.infoSnackBar;
        break;
      case SnackBarType.error:
        backgroundColor = ColorManager.snackBarEB;
        primaryColor = ColorManager.errorText;
        assetPath = AssetManager.errorSnackBar;
        break;
      case SnackBarType.notification:
        backgroundColor = ColorManager.snackBarNB;
        primaryColor = ColorManager.notificationText;
        assetPath = AssetManager.notificationSnackBar;
        break;
    }

    return ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          margin: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 16.h,
            ),
            margin: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              bottom: 10.h,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.5),
                  blurRadius: 6,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(
                8.w,
              ),
              border: Border.all(
                color: primaryColor,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  assetPath,
                  width: 25.w,
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 6.w,
                    ),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(
            seconds: 5,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static Widget authBackground({
    required Widget child,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorManager.primary,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0.h,
            child: SvgPicture.asset(
              AssetManager.authLogo,
              width: 360.w,
            ),
          ),
          Positioned(
            left: 42.w,
            top: 75.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 50.h,
                  ),
                  child: SvgPicture.asset(
                    AssetManager.logoWT,
                    width: 175.w,
                  ),
                ),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget emailTextField({
    required TextEditingController emailController,
    required FocusNode emailNode,
    required void Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: SizedBox(
        width: 275.w,
        child: TextFormField(
          onTapOutside: (value) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          onChanged: onChanged,
          controller: emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.deny(
              RegExp(
                '[ ]',
              ),
            ),
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.allow(
              RegExp(
                r'^[\w.@]+',
              ),
            ),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return null;
            }
            if (!ValidationManager.validateEmail(value)) {
              return StringManager.enterValidEmail;
            }
            return null;
          },
          focusNode: emailNode,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: ColorManager.white,
            hintText: StringManager.userEmail,
            hintStyle: GoogleFonts.oswald(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: ColorManager.labelText,
            ),
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
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.errorText,
              ),
              borderRadius: BorderRadius.circular(
                8.w,
              ),
            ),
            errorStyle: GoogleFonts.oswald(
              fontSize: 14.sp,
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
                AssetManager.email,
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
      ),
    );
  }

  static Widget passwordTextField({
    required TextEditingController passwordController,
    required Rx<FocusNode> passwordNode,
    required String? hintText,
    required void Function(String)? onChanged,
    required var obscureText,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: SizedBox(
        width: 275.w,
        child: Obx(() {
          return TextFormField(
            onTapOutside: (value) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            onChanged: onChanged,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                RegExp(
                  '[ ]',
                ),
              ),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            obscureText: obscureText.value,
            obscuringCharacter: '●',
            validator: (value) {
              if (value!.isEmpty) {
                return null;
              }
              if (value.length < 8) {
                return StringManager.passwordMinLength;
              }
              if (!value.contains(RegExp(r'[A-Z]'))) {
                return StringManager.passwordUppercase;
              }
              if (!value.contains(RegExp(r'[a-z]'))) {
                return StringManager.passwordLowercase;
              }
              if (!value.contains(RegExp(r'[0-9]'))) {
                return StringManager.passwordNumber;
              }
              if (!value.contains(RegExp(r'[!@#$%^&*()\-_=+{};:,<.>]'))) {
                return StringManager.passwordSymbol;
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: passwordNode.value,
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
                borderSide: const BorderSide(
                  color: ColorManager.errorText,
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
                fontSize: 14.sp,
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
                  AssetManager.password,
                  width: 7.w,
                ),
              ),
              suffixIcon: InkWell(
                onTap: () {
                  obscureText.value = !obscureText.value;
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 13.h,
                    left: 10.w,
                    right: 15.w,
                    bottom: 11.h,
                  ),
                  child: SvgPicture.asset(
                    obscureText.value
                        ? AssetManager.obscureClose
                        : AssetManager.obscureOpen,
                    width: 7.w,
                  ),
                ),
              ),
            ),
            style: GoogleFonts.oswald(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: ColorManager.labelText,
            ),
            cursorColor: ColorManager.cursor,
          );
        }),
      ),
    );
  }

  static Widget primaryButton({
    required String? buttonName,
    required var isEnable,
    required void Function()? onTap,
  }) {
    var isPressed = false.obs;
    return Obx(
      () => GestureDetector(
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
        onTap: isEnable.value ? onTap : null,
        child: Container(
          width: 275.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 35.h,
            bottom: 20.h,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? ColorManager.buttonPressed
                : isEnable.value
                    ? ColorManager.button
                    : ColorManager.button.withOpacity(
                        0.4,
                      ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            boxShadow: isEnable.value
                ? [
                    BoxShadow(
                      color: ColorManager.black.withOpacity(
                        0.2,
                      ),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ]
                : null,
          ),
          child: Text(
            buttonName!,
            style: GoogleFonts.oswald(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}

enum SnackBarType {
  success,
  info,
  error,
  notification,
}
