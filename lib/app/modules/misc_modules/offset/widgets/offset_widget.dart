import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/utils/color_manager.dart';

class OffsetWidget {
  OffsetWidget._();

  static Widget titleCanvasButton({
    required OffsetType type,
    required var content,
    required var amount,
    required var url,
    required var isEnable,
  }) {
    String title;

    switch (type) {
      case OffsetType.removal:
        title = StringManager.removal;
        break;
      case OffsetType.reforest:
        title = StringManager.reforest;
        break;
    }
    return Padding(
      padding: EdgeInsets.only(
        top: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10.w,
              bottom: 20.w,
              left: 20.h,
              right: 20.h,
            ),
            margin: EdgeInsets.only(
              top: 10.h,
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
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.h,
                  ),
                  child: Text(
                    title,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 22.sp,
                      color: ColorManager.displayText,
                    ),
                  ),
                ),
                Obx(
                  () {
                    return Html(
                      data: content.value,
                      onLinkTap: (url, _, __) async {
                        Uri uri = Uri.parse('$url');
                        String path = uri.path;
                        String host = uri.host;
                        List<String> pathSegments = path.split("/");
                        String desiredString =
                            pathSegments.length > 2 ? pathSegments[2] : "";
                        final Uri urls = Uri(
                          scheme: 'https',
                          host: host,
                          path: desiredString,
                        );
                        if (!await launchUrl(
                          urls,
                          mode: LaunchMode.inAppWebView,
                        )) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      style: {
                        'p': Style(
                          fontFamily: GoogleFonts.oswald().fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize(
                            14.sp,
                          ),
                          color: ColorManager.labelText,
                          lineHeight: LineHeight(
                            1.2.sp,
                          ),
                          padding: HtmlPaddings.zero,
                          margin: Margins.zero,
                        ),
                      },
                    );
                  },
                ),
                Divider(
                  color: ColorManager.primary,
                  thickness: 1.h,
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () {
                            return Text(
                              amount.value,
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: ColorManager.labelText,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 6.w,
                          ),
                          child: SvgPicture.asset(
                            AssetManager.euro,
                            width: 17.5.w,
                          ),
                        ),
                      ],
                    ),
                    offsetButton(
                      buttonName: StringManager.offset,
                      isEnable: isEnable,
                      onTap: () async {
                        Uri uri = Uri.parse('${url.value}');
                        String path = uri.path;
                        String host = uri.host;
                        List<String> pathSegments = path.split("/");
                        String desiredString =
                            pathSegments.length > 2 ? pathSegments[2] : "";
                        final Uri urls = Uri(
                          scheme: 'https',
                          host: host,
                          path: desiredString,
                        );
                        if (!await launchUrl(
                          urls,
                          mode: LaunchMode.inAppWebView,
                        )) {
                          throw Exception('Could not launch ${url.value}');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget offsetButton({
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
          width: 125.w,
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
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
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }

  static Widget canvasQA({
    required var title,
    required var content,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10.w,
              bottom: 20.w,
              left: 20.h,
              right: 20.h,
            ),
            margin: EdgeInsets.only(
              top: 10.h,
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
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.h,
                  ),
                  child: Obx(() {
                    return Text(
                      title.value,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 22.sp,
                        color: ColorManager.displayText,
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5.h,
                  ),
                  child: Obx(
                    () {
                      return Html(
                        data: content.value,
                        onLinkTap: (url, _, __) async {
                          Uri uri = Uri.parse('$url');
                          String path = uri.path;
                          String host = uri.host;
                          List<String> pathSegments = path.split("/");
                          String desiredString =
                              pathSegments.length > 2 ? pathSegments[2] : "";
                          final Uri urls = Uri(
                            scheme: 'https',
                            host: host,
                            path: desiredString,
                          );
                          if (!await launchUrl(
                            urls,
                            mode: LaunchMode.inAppWebView,
                          )) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        style: {
                          'p': Style(
                            fontFamily: GoogleFonts.oswald().fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize(
                              14.sp,
                            ),
                            color: ColorManager.labelText,
                            lineHeight: LineHeight(
                              1.6.sp,
                            ),
                          ),
                        },
                      );
                    },
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

enum OffsetType {
  removal,
  reforest,
}
