import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/gear/widgets/gearwidget.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';
import '../controllers/gear_controller.dart';

class GearView extends GetView<GearController> {
  const GearView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: WidgetManager.primaryAppBar(
          title: StringManager.gear,
          type: AppBarType.secondary,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringManager.gearStartingText,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: ColorManager.titleText,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    margin: EdgeInsets.only(
                      top: 8.h,
                      //bottom: 20.h,
                    ),
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(
                          8.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.button.withOpacity(
                              0.2,
                            ),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ]),
                    child: Column(
                      children: [
                        GearWidget.textWithField(
                          fieldName: StringManager.gearLabel1,
                          isEnable: controller.isEnable,
                          dropdownvalue: "1",
                        ),
                        GearWidget.textWithField(
                          fieldName: StringManager.gearLabel2,
                          isEnable: controller.isEnable,
                          dropdownvalue: "1",
                        ),
                        GearWidget.textWithField(
                          fieldName: StringManager.gearLabel3,
                          isEnable: controller.isEnable,
                          dropdownvalue: "1",
                        ),
                        GearWidget.textWithField(
                          fieldName: StringManager.gearLabel4,
                          isEnable: controller.isEnable,
                          dropdownvalue: "1",
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel5,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel6,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel7,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel8,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel9,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel10,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel11,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel2,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel13,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel14,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel15,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel16,
                                isEnable: controller.isEnable,
                                dropdownvalue: "1",
                              ),
                            ),
                          ],
                        ),
                        WidgetManager.primaryButton(
                          buttonName: StringManager.submit,
                          isEnable: controller.isEnable,
                          onTap: () async {
                            await controller.submitGears();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${StringManager.total}: ',
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: ColorManager.button,
                              ),
                            ),
                            Obx(() {
                              final totalValue = controller.total.value;
                              final displayValue =
                                  totalValue.isNaN ? 0.0 : totalValue;
                              return Text(
                                '$displayValue ${StringManager.kgProduced}',
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                  color: ColorManager.displayText,
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
