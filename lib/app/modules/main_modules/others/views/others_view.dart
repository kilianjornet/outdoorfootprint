import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/others/widgets/others_widget.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/widget_manager.dart';

import '../../gear/widgets/gearwidget.dart';
import '../controllers/others_controller.dart';

class OthersView extends GetView<OthersController> {
  const OthersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: WidgetManager.primaryAppBarWithBackButton(
          title: StringManager.others,
          type: AppBarType.primary,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringManager.logging,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: ColorManager.titleText,
                  ),
                ),
                SizedBox(height: 16.h,),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OthersWidgets.editFields(
                      controller: controller.labelController1,
                      node: controller.firstNameNode,
                      type: FieldType.firstName,
                      onChanged: (value) async {
                        controller.updateButtonState(value);
                      },
                      labelName: StringManager.othersLabel1,
                    ),
                  )

                ),
                SizedBox(height: 8.h,),
                Text(
                  StringManager.skiDay,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: ColorManager.titleText,
                  ),
                ),
                SizedBox(height: 8.h,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child:Column(
                        children: [
                          OthersWidgets.customFieldWithUnit(
                            type: UnitType.kgCoal,
                            subtitle: StringManager.othersLabel2,
                            controller: controller.labelController2,
                            node: controller.labelControllerNode2,
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                controller.labelController2.text = '0';
                              } else {
                                controller.updateButtonState(value);
                                //controller.calculateTotalCarbon();
                              }
                            },
                            unitName: StringManager.days,
                          ),
                          OthersWidgets.customFieldWithUnit(
                            type: UnitType.kgCoal,
                            subtitle: StringManager.othersLabel3,
                            controller: controller.labelController3,
                            node: controller.labelControllerNode3,
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                controller.labelController3.text = '0';
                              } else {
                                controller.updateButtonState(value);
                                //controller.calculateTotalCarbon();
                              }
                            },
                            unitName: StringManager.days,
                          ),
                          OthersWidgets.customFieldWithUnit(
                            type: UnitType.kgCoal,
                            subtitle: StringManager.othersLabel4,
                            controller: controller.labelController4,
                            node: controller.labelControllerNode4,
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                controller.labelController4.text = '0';
                              } else {
                                controller.updateButtonState(value);
                                //controller.calculateTotalCarbon();
                              }
                            },
                            unitName: StringManager.days,
                          ),
                        ],
                      ),
                    ),

                ),

                //Food Section
                SizedBox(height: 8.h,),
                Text(
                  StringManager.food,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: ColorManager.titleText,
                  ),
                ),
                SizedBox(height: 8.h,),
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
                        Row(
                          children: [
                            Expanded (
                              flex:1,
                              child : OthersWidgets.customFieldWithUnit(
                                type: UnitType.kg,
                                subtitle: StringManager.othersLabel5,
                                controller: controller.labelController5,
                                node: controller.labelControllerNode5,
                                onChanged: (value) async {
                                  if (value.isEmpty) {
                                    controller.labelController5.text = '0';
                                  } else {
                                    controller.updateButtonState(value);
                                    //controller.calculateTotalCarbon();
                                  }
                                },
                                unitName: StringManager.days,
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Expanded (
                              flex:1,
                              child : OthersWidgets.customFieldWithUnit(
                                type: UnitType.kg,
                                subtitle: StringManager.othersLabel6,
                                controller: controller.labelController6,
                                node: controller.labelControllerNode6,
                                onChanged: (value) async {
                                  if (value.isEmpty) {
                                    controller.labelController6.text = '0';
                                  } else {
                                    controller.updateButtonState(value);
                                    //controller.calculateTotalCarbon();
                                  }
                                },
                                unitName: StringManager.days,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded (
                              flex:1,
                              child : OthersWidgets.customFieldWithUnit(
                                type: UnitType.kg,
                                subtitle: StringManager.othersLabel7,
                                controller: controller.labelController7,
                                node: controller.labelControllerNode7,
                                onChanged: (value) async {
                                  if (value.isEmpty) {
                                    controller.labelController7.text = '0';
                                  } else {
                                    controller.updateButtonState(value);
                                    //controller.calculateTotalCarbon();
                                  }
                                },
                                unitName: StringManager.days,
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Expanded (
                              flex:1,
                              child : OthersWidgets.customFieldWithUnit(
                                type: UnitType.kg,
                                subtitle: StringManager.othersLabel8,
                                controller: controller.labelController8,
                                node: controller.labelControllerNode8,
                                onChanged: (value) async {
                                  if (value.isEmpty) {
                                    controller.labelController8.text = '0';
                                  } else {
                                    controller.updateButtonState(value);
                                    //controller.calculateTotalCarbon();
                                  }
                                },
                                unitName: StringManager.days,
                              ),
                            ),
                          ],
                        ),
                        OthersWidgets.customFieldWithUnit(
                          type: UnitType.kg,
                          subtitle: StringManager.othersLabel9,
                          controller: controller.labelController9,
                          node: controller.labelControllerNode9,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.labelController9.text = '0';
                            } else {
                              controller.updateButtonState(value);
                              //controller.calculateTotalCarbon();
                            }
                          },
                          unitName: StringManager.days,
                        ),
                      ],
                    ),

                ),

                //Others Section
                SizedBox(height: 8.h,),
                Text(
                  StringManager.others,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: ColorManager.titleText,
                  ),
                ),
                SizedBox(height: 8.h,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child:Column(
                        children: [
                          Row(
                            children: [
                              Expanded (
                                flex:1,
                                child : OthersWidgets.customFieldWithUnit(
                                  type: UnitType.kg,
                                  subtitle: StringManager.othersLabel10,
                                  controller: controller.labelController10,
                                  node: controller.labelControllerNode10,
                                  onChanged: (value) async {
                                    if (value.isEmpty) {
                                      controller.labelController10.text = '0';
                                    } else {
                                      controller.updateButtonState(value);
                                      //controller.calculateTotalCarbon();
                                    }
                                  },
                                  unitName: StringManager.days,
                                ),
                              ),
                              SizedBox(width: 8.w,),
                              Expanded (
                                flex:1,
                                child : OthersWidgets.customFieldWithUnit(
                                  type: UnitType.kg,
                                  subtitle: StringManager.othersLabel11,
                                  controller: controller.labelController11,
                                  node: controller.labelControllerNode11,
                                  onChanged: (value) async {
                                    if (value.isEmpty) {
                                      controller.labelController11.text = '0';
                                    } else {
                                      controller.updateButtonState(value);
                                      //controller.calculateTotalCarbon();
                                    }
                                  },
                                  unitName: StringManager.days,
                                ),
                              ),
                            ],
                          ),
                          OthersWidgets.customFieldWithUnit(
                            type: UnitType.kg,
                            subtitle: StringManager.othersLabel12,
                            controller: controller.labelController12,
                            node: controller.labelControllerNode12,
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                controller.labelController12.text = '0';
                              } else {
                                controller.updateButtonState(value);
                                //controller.calculateTotalCarbon();
                              }
                            },
                            unitName: StringManager.days,
                          ),
                          OthersWidgets.customFieldWithUnit(
                            type: UnitType.kg,
                            subtitle: StringManager.othersLabel13,
                            controller: controller.labelController13,
                            node: controller.labelControllerNode13,
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                controller.labelController13.text = '0';
                              } else {
                                controller.updateButtonState(value);
                                //controller.calculateTotalCarbon();
                              }
                            },
                            unitName: StringManager.days,
                          ),
                          Row(
                            children: [
                              Expanded (
                                flex:1,
                                child : OthersWidgets.customFieldWithUnit(
                                  type: UnitType.kg,
                                  subtitle: StringManager.othersLabel14,
                                  controller: controller.labelController14,
                                  node: controller.labelControllerNode14,
                                  onChanged: (value) async {
                                    if (value.isEmpty) {
                                      controller.labelController14.text = '0';
                                    } else {
                                      controller.updateButtonState(value);
                                      //controller.calculateTotalCarbon();
                                    }
                                  },
                                  unitName: StringManager.days,
                                ),
                              ),
                              SizedBox(width: 8.w,),
                              Expanded (
                                flex:1,
                                child : OthersWidgets.customFieldWithUnit(
                                  type: UnitType.kg,
                                  subtitle: StringManager.othersLabel15,
                                  controller: controller.labelController15,
                                  node: controller.labelControllerNode15,
                                  onChanged: (value) async {
                                    if (value.isEmpty) {
                                      controller.labelController15.text = '0';
                                    } else {
                                      controller.updateButtonState(value);
                                      //controller.calculateTotalCarbon();
                                    }
                                  },
                                  unitName: StringManager.days,
                                ),
                              ),
                            ],
                          ),
                          OthersWidgets.customFieldWithUnit(
                            type: UnitType.kg,
                            subtitle: StringManager.othersLabel16,
                            controller: controller.labelController16,
                            node: controller.labelControllerNode16,
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                controller.labelController16.text = '0';
                              } else {
                                controller.updateButtonState(value);
                                //controller.calculateTotalCarbon();
                              }
                            },
                            unitName: StringManager.days,
                          ),
                        ],
                      ),
                    ),

                ),

                //New Car section
                SizedBox(height: 8.h,),
                Text(
                  StringManager.newCar,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: ColorManager.titleText,
                  ),
                ),
                SizedBox(height: 8.h,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded (
                                flex:1,
                                child : GearWidget.textWithField(
                                  fieldName: StringManager.othersLabel17,
                                  isEnable: controller.isEnable,
                                  dropdownvalue: "1",
                                ),
                              ),
                              SizedBox(width: 8.w,),
                              Expanded (
                                flex:1,
                                child : GearWidget.textWithField(
                                  fieldName: StringManager.othersLabel18,
                                  isEnable: controller.isEnable,
                                  dropdownvalue: "1",
                                ),
                              ),
                            ],
                          ),
                          GearWidget.textWithField(
                            fieldName: StringManager.othersLabel19,
                            isEnable: controller.isEnable,
                            dropdownvalue: "1",
                          ),
                        ],
                      ),
                    )

                ),

                WidgetManager.primaryButton(
                  buttonName: StringManager.submit,
                  isEnable: controller.isEnable,
                  onTap: () async {},
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
                      final displayValue = totalValue.isNaN ? 0.0 : totalValue;
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
        )
    );
  }
}
