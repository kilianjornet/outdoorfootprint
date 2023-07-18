import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/color_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/tips_controller.dart';

class TipsView extends GetView<TipsController> {
  const TipsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.tip,
        type: AppBarType.tip,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 20.w,
          ),
          child: Column(
            children: [
              Obx(
                () {
                  return Text(
                    controller.tipsTitle.value,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: ColorManager.labelText,
                    ),
                  );
                },
              ),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: 15.h,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.list.value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapDown: (value) {
                        controller.isPressed[index].value = true;
                      },
                      onTapUp: (value) {
                        controller.isPressed[index].value = false;
                      },
                      onTap: () async {
                        controller.toggleExpand(
                          index,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        margin: EdgeInsets.only(
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: controller.isPressed[index].value
                              ? ColorManager.secondaryField
                              : ColorManager.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.boxShadow.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Obx(
                          () {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.list[index]['content_title'],
                                      style: GoogleFonts.oswald(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: ColorManager.labelText,
                                      ),
                                    ),
                                    RotatedBox(
                                      quarterTurns:
                                          controller.boolList[index].value
                                              ? 1
                                              : 0,
                                      child: SvgPicture.asset(
                                        AssetManager.arrowForward,
                                        width: 6.w,
                                      ),
                                    ),
                                  ],
                                ),
                                AnimatedSize(
                                  reverseDuration: const Duration(
                                    milliseconds: 250,
                                  ),
                                  curve: Curves.easeIn,
                                  duration: const Duration(
                                    milliseconds: 250,
                                  ),
                                  child: controller.boolList[index].value
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                            top: 10.h,
                                          ),
                                          child: Html(
                                            data: controller.list[index]
                                                ['content'],
                                            onLinkTap: (url, _, __) async {
                                              Uri uri = Uri.parse('$url');
                                              String path = uri.path;
                                              String host = uri.host;
                                              List<String> pathSegments =
                                                  path.split("/");
                                              String desiredString =
                                                  pathSegments.length > 2
                                                      ? pathSegments[2]
                                                      : "";
                                              final Uri urls = Uri(
                                                scheme: 'https',
                                                host: host,
                                                path: desiredString,
                                              );
                                              if (!await launchUrl(
                                                urls,
                                                mode: LaunchMode.inAppWebView,
                                              )) {
                                                throw Exception(
                                                    'Could not launch $url');
                                              }
                                            },
                                            style: {
                                              'p': Style(
                                                fontFamily: GoogleFonts.oswald()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w400,
                                                fontSize: FontSize(
                                                  14.sp,
                                                ),
                                                color: ColorManager.labelText,
                                                lineHeight: LineHeight(
                                                  1.6.sp,
                                                ),
                                              ),
                                              'ul': Style(
                                                fontFamily: GoogleFonts.oswald()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w400,
                                                fontSize: FontSize(
                                                  14.sp,
                                                ),
                                                color: ColorManager.labelText,
                                                lineHeight: LineHeight(
                                                  1.6.sp,
                                                ),
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                              ),
                                              'li': Style(
                                                padding: HtmlPaddings.only(
                                                  top: 5.h,
                                                ), // Adjust the left padding value as per your preference
                                              ),
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
