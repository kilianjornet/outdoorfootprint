import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/color_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

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
              Text(
                StringManager.tipTitle,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 24.sp,
                  color: ColorManager.labelText,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  top: 15.h,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.list.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    margin: EdgeInsets.only(
                      bottom: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.list[index]['title'],
                                  style: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: ColorManager.labelText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller.toggleExpand(
                                      index,
                                    );
                                  },
                                  child: RotatedBox(
                                    quarterTurns:
                                        controller.boolList[index].value
                                            ? 1
                                            : 0,
                                    child: SvgPicture.asset(
                                      AssetManager.arrowForward,
                                      width: 6.w,
                                    ),
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
                                      child: Text(
                                        controller.list[index]['content'],
                                        style: GoogleFonts.oswald(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: ColorManager.labelText,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
