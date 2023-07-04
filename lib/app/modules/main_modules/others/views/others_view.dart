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
                      child: SizedBox(),
                    )

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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(),
                    )

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
                      child: SizedBox(),
                    )

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
