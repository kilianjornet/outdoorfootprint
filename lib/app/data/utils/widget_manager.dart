import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/validation_manager.dart';

import '../../modules/misc_modules/custom_dialog/views/custom_dialog_view.dart';
import 'asset_manager.dart';
import 'color_manager.dart';

class WidgetManager {
  WidgetManager._();

  static ScaffoldMessengerState customSnackBar({
    required String title,
    String? body,
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
              bottom: type == SnackBarType.notification ? 475.h : 10.h,
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
                  width: type == SnackBarType.notification ? 20.w : 25.w,
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 6.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        type == SnackBarType.notification
                            ? Text(
                                '$body',
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: primaryColor,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(
            seconds: 3,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static Widget authBackground({
    required String title,
    String? subtitle,
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 75.h,
                      bottom: 50.h,
                    ),
                    child: SvgPicture.asset(
                      AssetManager.logoWT,
                      width: 175.w,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5.h,
                    ),
                    child: Text(
                      title,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        color: ColorManager.displayText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 35.h,
                    ),
                    child: Text(
                      title == StringManager.forgetPassword
                          ? StringManager.enterRegisteredEmail
                          : title == StringManager.verifyOtpTitle
                              ? '${StringManager.enterCode} $subtitle'
                              : title == StringManager.resetPasswordTitle
                                  ? StringManager.enterNewPassword
                                  : StringManager.greetingText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: title == StringManager.termsAndConditions
                            ? 0.sp
                            : 18.sp,
                        color: ColorManager.captionText,
                      ),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
          Visibility(
            visible: title == StringManager.termsAndConditions ||
                    title == StringManager.privacyPolicy
                ? true
                : false,
            child: Positioned(
              top: 55.h,
              left: 15.w,
              child: GestureDetector(
                onTap: () async {
                  Get.back();
                },
                child: SvgPicture.asset(
                  AssetManager.arrow,
                  width: 20.w,
                ),
              ),
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
    );
  }

  static Widget passwordTextField({
    required TextEditingController passwordController,
    required FocusNode passwordNode,
    required void Function(String)? onChanged,
    required var obscureText,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
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
          focusNode: passwordNode,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: ColorManager.white,
            hintText: StringManager.userPassword,
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
                      color: ColorManager.button.withOpacity(
                        0.5,
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

  static Widget confirmPasswordTextField({
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required FocusNode confirmPasswordNode,
    required void Function(String)? onChanged,
    required var obscureText,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: Obx(() => TextFormField(
            onTapOutside: (value) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            onChanged: onChanged,
            controller: confirmPasswordController,
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
              if (passwordController.text != confirmPasswordController.text) {
                return StringManager.passwordMismatch;
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: confirmPasswordNode,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: ColorManager.white,
              hintText: StringManager.confirmPassword,
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
            cursorColor: ColorManager.button,
          )),
    );
  }

  static Widget backToSignIn() {
    return GestureDetector(
      onTap: () async {
        await Get.offAllNamed(
          '/sign-in',
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 25.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetManager.longArrow,
              width: 20.w,
            ),
            Text(
              '  ${StringManager.backToSignIn}',
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: ColorManager.subtitleText,
              ),
            )
          ],
        ),
      ),
    );
  }

  static PreferredSizeWidget primaryAppBar({
    required String title,
    required AppBarType type,
    Widget? child,
    Widget? dialog,
    var openDialog,
  }) {
    String offsetPath;
    String tipPath;
    String notificationPath;

    switch (type) {
      case AppBarType.primary:
        offsetPath = AssetManager.offsetD;
        tipPath = AssetManager.tipD;
        notificationPath = AssetManager.notificationD;
        break;
      case AppBarType.secondary:
        offsetPath = AssetManager.offsetD;
        tipPath = AssetManager.tipD;
        notificationPath = AssetManager.notificationD;
        break;
      case AppBarType.home:
        offsetPath = AssetManager.offsetD;
        tipPath = AssetManager.tipD;
        notificationPath = AssetManager.notificationD;
        break;
      case AppBarType.offset:
        offsetPath = AssetManager.offsetE;
        tipPath = AssetManager.tipD;
        notificationPath = AssetManager.notificationD;
        break;
      case AppBarType.tip:
        offsetPath = AssetManager.offsetD;
        tipPath = AssetManager.tipE;
        notificationPath = AssetManager.notificationD;
        break;
      case AppBarType.notification:
        offsetPath = AssetManager.offsetD;
        tipPath = AssetManager.tipD;
        notificationPath = AssetManager.notificationE;
        break;
    }
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.white,
      leading: const SizedBox(),
      leadingWidth: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          type == AppBarType.home
              ? GestureDetector(
                  onTap: () async {
                    openDialog.value = true;
                    Get.dialog(
                      dialog!,
                      barrierDismissible: true,
                      barrierColor: ColorManager.button.withOpacity(
                        0.5,
                      ),
                      transitionCurve: Curves.easeInOut,
                      transitionDuration: const Duration(
                        milliseconds: 300,
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 45.w,
                        height: 45.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.avatar,
                        ),
                      ),
                      CircleAvatar(
                        radius: 19.w,
                        backgroundColor: ColorManager.white,
                        child: ClipOval(
                          child: child,
                        ),
                      )
                    ],
                  ),
                )
              : Row(
                  children: [
                    type == AppBarType.primary
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () async {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              AssetManager.arrow,
                              width: 20.w,
                            ),
                          ),
                    Text(
                      type == AppBarType.primary ? title : '  $title',
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: ColorManager.displayText,
                      ),
                    ),
                  ],
                ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  if (type == AppBarType.offset ||
                      type == AppBarType.tip ||
                      type == AppBarType.notification) {
                    await Get.offNamed('/offset');
                  } else {
                    await Get.toNamed('/offset');
                  }
                },
                child: SvgPicture.asset(
                  offsetPath,
                  width: 20.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: GestureDetector(
                  onTap: () async {
                    if (type == AppBarType.offset ||
                        type == AppBarType.tip ||
                        type == AppBarType.notification) {
                      await Get.offNamed('/tips');
                    } else {
                      await Get.toNamed('/tips');
                    }
                  },
                  child: SvgPicture.asset(
                    tipPath,
                    width: 15.w,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (type == AppBarType.offset ||
                      type == AppBarType.tip ||
                      type == AppBarType.notification) {
                    await Get.offNamed('/notification');
                  } else {
                    await Get.toNamed('/notification');
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(
                    10.h,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.white,
                    boxShadow: type == AppBarType.notification
                        ? [
                            BoxShadow(
                              color: ColorManager.boxShadow.withOpacity(0.3),
                              offset: const Offset(2, 2),
                              blurRadius: 10,
                              spreadRadius: -5,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: ColorManager.boxShadow.withOpacity(
                                0.3,
                              ),
                              spreadRadius: -3,
                              blurRadius: 8,
                            ),
                          ],
                    gradient: type == AppBarType.notification
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorManager.secondaryField,
                              Color(0xFFFFFFFF),
                            ],
                          )
                        : null,
                    border: Border.all(
                      color: ColorManager.white,
                      width: 0.5.w,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: type == AppBarType.notification
                          ? [
                              BoxShadow(
                                color: ColorManager.black.withOpacity(0.25),
                                offset: const Offset(0, 0),
                                blurRadius: 12,
                                spreadRadius: -3,
                              ),
                            ]
                          : null,
                    ),
                    child: SvgPicture.asset(
                      notificationPath,
                      width: 12.5.w,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static InputDecoration? searchBarDecoration() {
    return InputDecoration(
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
    );
  }

  static TextStyle? countryTextStyle() {
    return GoogleFonts.oswald(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: ColorManager.white,
    );
  }

  static Widget? countryPickerTitle() {
    return Container(
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
    );
  }

  static void showCustomDialog() {
    Get.dialog(
      CustomDialogView(),
      barrierDismissible: false,
      barrierColor: ColorManager.button.withOpacity(
        0.5,
      ),
    );
  }

  static void hideCustomDialog() {
    Get.isDialogOpen! ? Get.back() : null;
  }

  static Widget titleWhiteCanvas({
    required String title,
    String? subtitle,
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w400,
              fontSize: 22.sp,
              color: ColorManager.displayText,
            ),
          ),
          subtitle == null
              ? const SizedBox()
              : Text(
                  subtitle,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: ColorManager.labelText,
                  ),
                ),
          Container(
            padding: EdgeInsets.only(
              top: 10.w,
              bottom: 10.w,
              left: 20.h,
              right: 20.h,
            ),
            margin: EdgeInsets.only(
              top: 15.h,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(
                10.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.boxShadow.withOpacity(
                    0.3,
                  ),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  static void showNumberPicker({
    required TextEditingController controller,
    required DropdownType type,
    required void Function(int)? onSelectedItemChanged,
  }) {
    int number;

    switch (type) {
      case DropdownType.adult:
        number = 20;
        break;
      case DropdownType.plane:
        number = 101;
        break;
      case DropdownType.car:
        number = 6;
        break;
    }

    showCupertinoModalPopup(
      filter: ImageFilter.blur(
        sigmaY: 3,
        sigmaX: 3,
      ),
      barrierColor: ColorManager.button.withOpacity(
        0.5,
      ),
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
          ),
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 40.sp,
            scrollController: FixedExtentScrollController(
              initialItem: type == DropdownType.adult
                  ? int.tryParse(controller.text)! - 1
                  : int.tryParse(controller.text)!,
            ),
            onSelectedItemChanged: onSelectedItemChanged,
            children: List<Widget>.generate(
              number,
              (int index) {
                return Center(
                  child: Text(
                    type == DropdownType.adult ? '${index + 1}' : '$index',
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 22.sp,
                      color: ColorManager.labelText,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static Widget whiteCanvas({
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10.w,
            bottom: 10.w,
            left: 20.h,
            right: 20.h,
          ),
          margin: EdgeInsets.only(
            top: 15.h,
          ),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(
              10.w,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorManager.boxShadow.withOpacity(
                  0.3,
                ),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  static Widget pieChart({
    required var co2Home,
    required var co2Mobility,
    required var co2Gear,
    required var co2Food,
  }) {
    return Obx(() {
      return PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: ColorManager.pieHome,
              value: co2Home.value,
              radius: 35.w,
              showTitle: false,
            ),
            PieChartSectionData(
              color: ColorManager.pieMobility,
              value: co2Mobility.value,
              radius: 35.w,
              showTitle: false,
            ),
            PieChartSectionData(
              color: ColorManager.pieGear,
              value: co2Gear.value,
              radius: 35.w,
              showTitle: false,
            ),
            PieChartSectionData(
              color: ColorManager.pieFood,
              value: co2Food.value,
              radius: 35.w,
              showTitle: false,
            ),
          ],
          centerSpaceRadius: 75.w,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 10.w,
        ),
      );
    });
  }

  static Widget totalData({
    required DataType type,
    required var total,
  }) {
    String assetPath;
    String title;

    switch (type) {
      case DataType.home:
        assetPath = AssetManager.home;
        title = StringManager.calculatorCat1;
        break;
      case DataType.mobility:
        assetPath = AssetManager.car;
        title = StringManager.calculatorCat2;
        break;
      case DataType.gear:
        assetPath = AssetManager.gear;
        title = StringManager.calculatorCat3;
        break;
      case DataType.others:
        assetPath = AssetManager.food;
        title = StringManager.calculatorCat4;
        break;
      case DataType.public:
        assetPath = AssetManager.publicService;
        title = StringManager.calculatorCat5;
        break;
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 30.w,
                child: SvgPicture.asset(
                  assetPath,
                  width: 15.w,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: ColorManager.labelText,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Obx(
                () {
                  return Text(
                    '${total.value}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: ColorManager.displayText,
                    ),
                  );
                },
              ),
              Text(
                ' ${StringManager.kgCo}',
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: ColorManager.labelText,
                ),
              ),
            ],
          )
        ],
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

enum AppBarType {
  primary,
  secondary,
  home,
  offset,
  tip,
  notification,
}

enum DropdownType {
  adult,
  plane,
  car,
}

enum DataType {
  home,
  mobility,
  gear,
  others,
  public,
}
