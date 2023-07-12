import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';
import '../controllers/add_controller.dart';
import '../widgets/add_widgets.dart';

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
                  fontSize: 20.sp,
                  color: ColorManager.displayText,
                ),
              ),
              AddWidget.calculatorPageButton1(
                buttonName: StringManager.calculatorCat1,
                isEnable: controller.isEnable,
                onTap: () async {
                  await Get.toNamed(
                    '/house',
                  );
                },
              ),
              AddWidget.calculatorPageButton2(
                buttonName: StringManager.calculatorCat2,
                isEnable: controller.isEnable,
                onTap: () async {
                  await Get.toNamed(
                    '/mobility',
                  );
                },
              ),
              AddWidget.calculatorPageButton3(
                buttonName: StringManager.calculatorCat3,
                isEnable: controller.isEnable,
                onTap: () async {
                  await Get.toNamed(
                    '/gear',
                  );
                },
              ),
              AddWidget.calculatorPageButton4(
                buttonName: StringManager.calculatorCat4,
                isEnable: controller.isEnable,
                onTap: () async {
                  await Get.toNamed(
                    '/others',
                  );
                },
              ),
              // AddWidget.calculatorPageButton5(
              //   buttonName: StringManager.calculatorCat5,
              //   isEnable: controller.isEnable,
              //   onTap: () async {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
