import 'dart:ui';

import 'package:flutter/cupertino.dart';
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

class ProfileWidget {
  ProfileWidget._();

  static Widget profilePicture({
    required Widget? child,
    required void Function() fromCamera,
    required void Function() fromGallery,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: 15.h,
        bottom: 50.h,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 130.w,
                height: 130.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.white,
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
              ),
              CircleAvatar(
                radius: 60.w,
                backgroundColor: ColorManager.white,
                child: ClipOval(
                  child: child,
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () async {
              await showCupertinoModalPopup<void>(
                barrierDismissible: false,
                filter: ImageFilter.blur(
                  sigmaY: 3,
                  sigmaX: 3,
                ),
                barrierColor: ColorManager.button.withOpacity(
                  0.5,
                ),
                context: Get.context!,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: Text(
                    StringManager.uploadImage,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: ColorManager.captionText,
                    ),
                  ),
                  message: Text(
                    StringManager.selectImageOption,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      height: 0.1,
                      color: ColorManager.labelText,
                    ),
                  ),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      onPressed: fromCamera,
                      child: Text(
                        StringManager.clickPicture,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          color: ColorManager.button,
                        ),
                      ),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: fromGallery,
                      child: Text(
                        StringManager.uploadFromCamera,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          color: ColorManager.button,
                        ),
                      ),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      StringManager.cancel,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                        color: ColorManager.errorText,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 80.h,
              ),
              padding: EdgeInsets.all(
                12.w,
              ),
              decoration: const BoxDecoration(
                color: ColorManager.primary,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AssetManager.pencil,
                width: 12.5.w,
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget editFields({
    required TextEditingController controller,
    required FocusNode node,
    required FieldType type,
    required void Function(String)? onChanged,
    void Function()? onTap,
  }) {
    String title;
    TextInputType inputType;
    List<TextInputFormatter>? inputFormatter;
    String? Function(String?)? validator;

    switch (type) {
      case FieldType.firstName:
        title = StringManager.firstName;
        inputType = TextInputType.name;
        inputFormatter = [
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
        ];
        validator = (value) {
          if (value!.isEmpty) {
            return null;
          }
          if (!ValidationManager.validateName(value)) {
            return StringManager.enterValidFirstName;
          }
          return null;
        };
        break;
      case FieldType.lastName:
        title = StringManager.lastName;
        inputType = TextInputType.name;
        inputFormatter = [
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
        ];
        validator = (value) {
          if (value!.isEmpty) {
            return null;
          }
          if (!ValidationManager.validateName(value)) {
            return StringManager.enterValidLastName;
          }
          return null;
        };
        break;
      case FieldType.email:
        title = StringManager.userEmail;
        inputType = TextInputType.emailAddress;
        inputFormatter = [
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
        ];
        validator = (value) {
          if (value!.isEmpty) {
            return null;
          }
          if (!ValidationManager.validateEmail(value)) {
            return StringManager.enterValidEmail;
          }
          return null;
        };
        break;
      case FieldType.country:
        title = StringManager.country;
        inputType = TextInputType.name;
        break;
      case FieldType.phoneNumber:
        title = StringManager.phoneNumber;
        inputType = TextInputType.phone;
        inputFormatter = [
          FilteringTextInputFormatter.digitsOnly,
        ];
        validator = (value) {
          if (value!.isEmpty) {
            return null;
          }
          if (!ValidationManager.validateNumber(value)) {
            return StringManager.enterValidPhoneNumber;
          }
          return null;
        };
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
          ),
          child: Text(
            title,
            style: GoogleFonts.oswald(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.labelText,
            ),
          ),
        ),
        TextFormField(
          onTapOutside: (value) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          onChanged: onChanged,
          onTap: type == FieldType.country ? onTap : null,
          controller: controller,
          readOnly: type == FieldType.country ||
                  type == FieldType.email ||
                  type == FieldType.phoneNumber
              ? true
              : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: inputType,
          inputFormatters: inputFormatter,
          validator: validator,
          focusNode: node,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: ColorManager.secondaryField,
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
          ),
          style: GoogleFonts.oswald(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.labelText,
          ),
          cursorColor: ColorManager.cursor,
        ),
      ],
    );
  }
}

enum FieldType {
  firstName,
  lastName,
  email,
  country,
  phoneNumber,
}
