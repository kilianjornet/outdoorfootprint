import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/add/wigets/calculator.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';
import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  const AddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: WidgetManager.primaryAppBar(
          title: StringManager.addCal,
          type: AppBarType.primary,
        ),
        body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
            child: Padding(
            padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.selectCat,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: ColorManager.titleText,
                    ),
                  ),
                  CalculatorWidget.calculatorPageButton1(
                    buttonName: StringManager.calculatorCat1,
                    isEnable: controller.isEnable,
                    onTap: () async {},
                  ),
                  CalculatorWidget.calculatorPageButton2(
                    buttonName: StringManager.calculatorCat2,
                    isEnable: controller.isEnable,
                    onTap: () async {},
                  ),
                  CalculatorWidget.calculatorPageButton3(
                    buttonName: StringManager.calculatorCat3,
                    isEnable: controller.isEnable,
                    onTap: () async {},
                  ),
                  CalculatorWidget.calculatorPageButton4(
                    buttonName: StringManager.calculatorCat4,
                    isEnable: controller.isEnable,
                    onTap: () async {},
                  ),
                  CalculatorWidget.calculatorPageButton5(
                    buttonName: StringManager.calculatorCat5,
                    isEnable: controller.isEnable,
                    onTap: () async {},
                  ),

                ],
              ),
          ),
        ),
    );
  }
}
