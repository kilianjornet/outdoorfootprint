import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/widget_manager.dart';
import '../controllers/offset_controller.dart';
import 'my_year_view.dart';

class OffsetView extends GetView<OffsetController> {
  const OffsetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.offset,
        type: AppBarType.offset,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Container(
              width: ScreenUtil().screenWidth,
              margin: EdgeInsets.only(
                top: 10.h,
              ),
              decoration: BoxDecoration(
                color: ColorManager.button,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.boxShadow.withOpacity(
                      0.3,
                    ),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  8.w,
                ),
              ),
              child: Obx(
                () {
                  return
                      // CupertinoSlidingSegmentedControl<int>(
                      // groupValue: controller.currentIndex.value,
                      // children: {
                      //   0:
                      Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    child: Text(
                      StringManager.myYear,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: controller.currentIndex.value == 0
                            ? ColorManager.white
                            : ColorManager.labelText,
                      ),
                    ),
                  );
                  // ,1: Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     vertical: 10.h,
                  //   ),
                  //   child: Text(
                  //     StringManager.custom,
                  //     style: GoogleFonts.oswald(
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 18.sp,
                  //       color: controller.currentIndex.value == 1
                  //           ? ColorManager.white
                  //           : ColorManager.labelText,
                  //     ),
                  //   ),
                  // ),
                  //   },
                  //   backgroundColor: ColorManager.white,
                  //   thumbColor: ColorManager.button,
                  //   onValueChanged: (index) {
                  //     controller.currentIndex.value = index!;
                  //     controller.pageController.animateToPage(
                  //       controller.currentIndex.value,
                  //       duration: const Duration(milliseconds: 300),
                  //       curve: Curves.easeInOut,
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                controller.currentIndex.value = index;
              },
              children: const [
                MyYearView(),
                // CustomView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
