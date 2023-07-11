import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/utils/asset_manager.dart';
import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/validation_manager.dart';
import '../../../calculator_modules/house/views/gas_dialog_view.dart';
import '../../../calculator_modules/house/views/oil_dialog_view.dart';

class OthersWidgets {
  OthersWidgets._();
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
                child: const SizedBox(),
              ))
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
    required String? labelName,
  }) {
    String title;
    TextInputType inputType;
    List<TextInputFormatter>? inputFormatter;
    String? Function(String?)? validator;

    switch (type) {
      case FieldType.firstName:
        title = labelName!;
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
      case FieldType.digits:
        title = labelName!;
        inputType = TextInputType.name;
          inputFormatter = [
          FilteringTextInputFormatter.digitsOnly,
          ];
        validator = (value) {
          if (value!.isEmpty) {
            return null;
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
          readOnly: type == FieldType.country ? true : false,
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

  static Widget customFieldWithUnit({
    String? subtitle,
    var gasUnit,
    var oilUnit,
    required TextEditingController controller,
    required FocusNode node,
    required UnitType type,
    required void Function(String)? onChanged,
    required String? unitName,
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
          unitName!,
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
        text = const SizedBox();
        asset = SvgPicture.asset(
          AssetManager.errIcon,
          width: 20.w,
        );
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
              Container(
                alignment: Alignment.center,
                width: 75.w,
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
                    GestureDetector(
                      onTap: onTap,
                      child: asset,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
  digits,
}

enum UnitType {
  cubicMeter,
  kgCoal,
  kg,
  litres,
  kwh,
  gb,
}
