import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../data/utils/api_manager.dart';
import '../../../../../data/utils/asset_manager.dart';
import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';

class OthersWidgets {
  OthersWidgets._();

  static Widget customFieldWithUnit({
    required String subtitle,
    var quantityUnit,
    var distanceUnit,
    void Function(int)? onSelectedItemChanged,
    required TextEditingController controller,
    required FocusNode node,
    required UnitType type,
    required void Function(String)? onChanged,
  }) {
    Widget text;
    Widget asset;
    MainAxisAlignment mainAxisAlignment;
    void Function()? onTap;

    switch (type) {
      case UnitType.days:
        text = Text(
          StringManager.days,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManager.white,
          ),
        );
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case UnitType.euro:
        text = const SizedBox();
        asset = SvgPicture.asset(
          AssetManager.errIcon,
          height: 20.h,
        );
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case UnitType.none:
        text = const SizedBox();
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case UnitType.car:
        text = const SizedBox();
        asset = const SizedBox();
        mainAxisAlignment = MainAxisAlignment.center;
        onTap = () async {
          WidgetManager.showNumberPicker(
            controller: controller,
            type: DropdownType.car,
            onSelectedItemChanged: onSelectedItemChanged,
          );
        };
        break;
    }
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
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onTapOutside: (value) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  onChanged: onChanged,
                  onTap: type == UnitType.car ? onTap : null,
                  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: type == UnitType.days
                      ? [
                          FilteringTextInputFormatter.deny(RegExp(r'^0')),
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
                        ]
                      : [
                          FilteringTextInputFormatter.deny(RegExp(r'^0')),
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r'^\d+\.?\d{0,2}',
                            ),
                          ),
                          // FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
                        ],
                  focusNode: node,
                  readOnly: type == UnitType.car ? true : false,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorManager.secondaryField,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorManager.button,
                      ),
                      borderRadius:
                          type == UnitType.none || type == UnitType.car
                              ? BorderRadius.all(Radius.circular(
                                  10.w,
                                ))
                              : BorderRadius.only(
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
                      borderRadius:
                          type == UnitType.none || type == UnitType.car
                              ? BorderRadius.all(Radius.circular(
                                  10.w,
                                ))
                              : BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10.w,
                                  ),
                                  bottomLeft: Radius.circular(
                                    10.w,
                                  ),
                                ),
                    ),
                    suffixIcon: type == UnitType.car
                        ? Container(
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
                          )
                        : null,
                  ),
                  style: GoogleFonts.oswald(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.labelText,
                  ),
                  cursorColor: ColorManager.cursor,
                ),
              ),
              type == UnitType.none || type == UnitType.car
                  ? const SizedBox()
                  : Container(
                      alignment: Alignment.center,
                      width: type == UnitType.days ? 75.w : 50.w,
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
                          asset,
                        ],
                      ),
                    ),
            ],
          ),
        ),
        type == UnitType.none
            ? Row(
                children: [
                  Text(
                    '${StringManager.skiDayHotelLabel}: ',
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: ColorManager.labelText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri(
                        scheme: 'https',
                        host: ApiManager.hotelUrl,
                      );
                      if (!await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Text(
                      StringManager.visitLink,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                        color: ColorManager.button,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}

enum UnitType {
  days,
  euro,
  none,
  car,
}
