import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/others/widgets/others_widget.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';
import '../controllers/others_controller.dart';

class OthersView extends GetView<OthersController> {
  const OthersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.others,
        type: AppBarType.secondary,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 20.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WidgetManager.titleWhiteCanvas(
                title: StringManager.logging,
                children: [
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel1,
                    controller: controller.hotelController,
                    node: controller.hotelNode,
                    type: UnitType.none,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.hotelController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.skiDay,
                subtitle: StringManager.skiDayDetails,
                children: [
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel2,
                    controller: controller.scandinaviaController,
                    node: controller.scandinaviaNode,
                    type: UnitType.days,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.scandinaviaController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel3,
                    controller: controller.usaController,
                    node: controller.usaNode,
                    type: UnitType.days,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.usaController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel4,
                    controller: controller.alpsController,
                    node: controller.alpsNode,
                    type: UnitType.days,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.alpsController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.food,
                subtitle: StringManager.foodDetails,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel5,
                          controller: controller.veganController,
                          node: controller.veganNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.veganController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel6,
                          controller: controller.vegetarianController,
                          node: controller.vegetarianNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.vegetarianController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel7,
                          controller: controller.lowController,
                          node: controller.lowNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.lowController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel8,
                          controller: controller.mediumMeatController,
                          node: controller.mediumMeatNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.mediumMeatController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel9,
                    controller: controller.heavyController,
                    node: controller.heavyNode,
                    type: UnitType.euro,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.heavyController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.others,
                subtitle: StringManager.othersDetails,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel10,
                          controller: controller.pharmaController,
                          node: controller.pharmaNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.pharmaController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel11,
                          controller: controller.computerController,
                          node: controller.computerNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.computerController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel12,
                    controller: controller.furnitureController,
                    node: controller.furnitureNode,
                    type: UnitType.euro,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.furnitureController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel13,
                    controller: controller.telephoneController,
                    node: controller.telephoneNode,
                    type: UnitType.euro,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.telephoneController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel14,
                          controller: controller.bankController,
                          node: controller.bankNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.bankController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel15,
                          controller: controller.insuranceController,
                          node: controller.insuranceNode,
                          type: UnitType.euro,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.insuranceController.text = '0';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            } else {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel16,
                    controller: controller.educationController,
                    node: controller.educationNode,
                    type: UnitType.euro,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.educationController.text = '0';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      } else {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.newCar,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel17,
                          controller: controller.smallController,
                          node: controller.smallNode,
                          type: UnitType.car,
                          onChanged: (value) async {
                            controller.calculateConversion();
                            controller.updateButtonState();
                          },
                          onSelectedItemChanged: (int index) {
                            controller.smallController.text = '$index';
                            controller.calculateConversion();
                            controller.updateButtonState();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: OthersWidgets.customFieldWithUnit(
                          subtitle: StringManager.othersLabel18,
                          controller: controller.mediumCarController,
                          node: controller.mediumCarNode,
                          type: UnitType.car,
                          onChanged: (value) async {
                            controller.calculateConversion();
                            controller.updateButtonState();
                          },
                          onSelectedItemChanged: (int index) {
                            controller.mediumCarController.text = '$index';
                            controller.calculateConversion();
                            controller.updateButtonState();
                          },
                        ),
                      ),
                    ],
                  ),
                  OthersWidgets.customFieldWithUnit(
                    subtitle: StringManager.othersLabel19,
                    controller: controller.bigController,
                    node: controller.bigNode,
                    type: UnitType.car,
                    onChanged: (value) async {
                      controller.calculateConversion();
                      controller.updateButtonState();
                    },
                    onSelectedItemChanged: (int index) {
                      controller.bigController.text = '$index';
                      controller.calculateConversion();
                      controller.updateButtonState();
                    },
                  ),
                ],
              ),
              WidgetManager.primaryButton(
                buttonName: StringManager.submit,
                isEnable: controller.isEnable,
                onTap: () async {
                  await controller.submitOthers();
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
                    final displayValue = totalValue.isNaN ? 0.0 : totalValue;
                    final formattedValue = displayValue.toStringAsFixed(2);
                    return Text(
                      '$formattedValue ${StringManager.kgProduced}',
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
      ),
    );
  }
}
