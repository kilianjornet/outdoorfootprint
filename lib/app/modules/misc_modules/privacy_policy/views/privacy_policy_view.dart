import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/widget_manager.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetManager.authBackground(
        title: StringManager.privacyPolicy,
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
