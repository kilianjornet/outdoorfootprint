import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';
import '../controllers/gear_controller.dart';
import '../widgets/gearwidget.dart';

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
                          dropdownvalue: controller.selectedDropdownValue1,
                          onChanged: (value) {
                            controller.selectedDropdownValue1.value = value!;
                            controller.calculateConversion();
                          },
                        ),
                        /*GearWidget.textWithField(
                          fieldName: StringManager.gearLabel2,
                          isEnable: controller.isEnable,
                          dropdownvalue: controller.selectedDropdownValue2,
                          onChanged: (value) {
                            controller.selectedDropdownValue2.value = value!;
                            controller.calculateConversion();
                          },
                        ),*/
                        GearWidget.textWithField(
                          fieldName: StringManager.gearLabel3,
                          isEnable: controller.isEnable,
                          dropdownvalue: controller.selectedDropdownValue3,
                          onChanged: (value) {
                            controller.selectedDropdownValue3.value = value!;
                            controller.calculateConversion();
                          },
                        ),
                        GearWidget.textWithField(
                          fieldName: StringManager.gearLabel4,
                          isEnable: controller.isEnable,
                          dropdownvalue: controller.selectedDropdownValue4,
                          onChanged: (value) {
                            controller.selectedDropdownValue4.value = value!;
                            controller.calculateConversion();
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GearWidget.textWithField(
                                fieldName: StringManager.gearLabel5,
                                isEnable: controller.isEnable,
                                dropdownvalue: controller.selectedDropdownValue5,
                                onChanged: (value) {
                                  controller.selectedDropdownValue5.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue6,
                                onChanged: (value) {
                                  controller.selectedDropdownValue6.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue7,
                                onChanged: (value) {
                                  controller.selectedDropdownValue7.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue8,
                                //totalConversion: controller.calculateConversion,
                                onChanged: (value) {
                                  controller.selectedDropdownValue8.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue9,
                                onChanged: (value) {
                                  controller.selectedDropdownValue9.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue10,
                                onChanged: (value) {
                                  controller.selectedDropdownValue10.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue11,
                                onChanged: (value) {
                                  controller.selectedDropdownValue11.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue12,
                                onChanged: (value) {
                                  controller.selectedDropdownValue12.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue13,
                                onChanged: (value) {
                                  controller.selectedDropdownValue13.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue14,
                                onChanged: (value) {
                                  controller.selectedDropdownValue14.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue15,
                                onChanged: (value) {
                                  controller.selectedDropdownValue15.value = value!;
                                  controller.calculateConversion();
                                },
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
                                dropdownvalue: controller.selectedDropdownValue16,
                                onChanged: (value) {
                                  controller.selectedDropdownValue16.value = value!;
                                  controller.calculateConversion();
                                },
                              ),
                            ),
                          ],
                        ),
                        WidgetManager.primaryButton(
                          buttonName: StringManager.submit,
                          isEnable: controller.isButtonEnable,
                          onTap: () async {
                            controller.calculateConversion();
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
