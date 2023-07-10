import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

import '../../../../data/utils/color_manager.dart';
import '../controllers/terms_condition_controller.dart';

class TermsConditionView extends GetView<TermsConditionController> {
  const TermsConditionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetManager.authBackground(
        title: StringManager.termsCondition,
        child: WidgetManager.whiteCanvas(
          children: [
            Obx(
              () {
                return Html(
                  data: controller.content.value,
                  style: {
                    'p': Style(
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize(
                        15.sp,
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
          ],
        ),
      ),
    );
  }
}
