import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
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
        child: Html(
          data: controller.content['cms']['content'],
          style: {
            'p': Style(
              fontWeight: FontWeight.w400,
              fontSize: FontSize(30),
              wordSpacing: 3,
              color: ColorManager.labelText,
              lineHeight: const LineHeight(1.6),
            ),
          },
        ),
      ),
    );
  }
}
