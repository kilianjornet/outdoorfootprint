import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/profile/widgets/profile_widget.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/validation_manager.dart';

class OthersWidgets{
  OthersWidgets._();
  static Widget textWithField({
    required String? fieldName,
    required var isEnable,
    required String?dropdownvalue,
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
          SizedBox(height: 8.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  color:ColorManager.dropdownColor, //background color of dropdown button
                  border: Border.all(color: ColorManager.dropdownColor,
                      width:3), //border of dropdown button
                  borderRadius: BorderRadius.circular(8), //border raiuds of dropdown button
                ),

                child:SizedBox(),
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
    required String?labelName,
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

}
enum FieldType {
  firstName,
  lastName,
  email,
  country,
  phoneNumber,
}