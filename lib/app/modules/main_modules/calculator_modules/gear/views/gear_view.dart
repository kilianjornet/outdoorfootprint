import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/gear/widgets/gear_widget.dart';

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
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.gearTitle,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: ColorManager.labelText,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10.w,
                  bottom: 10.w,
                  left: 20.h,
                  right: 20.h,
                ),
                margin: EdgeInsets.only(
                  top: 15.h,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(
                    10.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.boxShadow.withOpacity(
                        0.3,
                      ),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GearWidget.customFieldWithUnit(
                      subtitle: StringManager.runningShoe,
                      controller: controller.runningController,
                      node: controller.runningNode,
                      onChanged: (value) async {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                      onSelectedItemChanged: (int index) {
                        controller.runningController.text = '$index';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                    ),
                    GearWidget.customFieldWithUnit(
                      subtitle: StringManager.skis,
                      controller: controller.skisController,
                      node: controller.skisNode,
                      onChanged: (value) async {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                      onSelectedItemChanged: (int index) {
                        controller.skisController.text = '$index';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                    ),
                    GearWidget.customFieldWithUnit(
                      subtitle: StringManager.climbingRope,
                      controller: controller.ropeController,
                      node: controller.ropeNode,
                      onChanged: (value) async {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                      onSelectedItemChanged: (int index) {
                        controller.ropeController.text = '$index';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                    ),
                    GearWidget.customFieldWithUnit(
                      subtitle: StringManager.climbingGear,
                      controller: controller.gearController,
                      node: controller.gearNode,
                      onChanged: (value) async {
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                      onSelectedItemChanged: (int index) {
                        controller.gearController.text = '$index';
                        controller.calculateConversion();
                        controller.updateButtonState();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 132.5.w,
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.bike,
                            controller: controller.bikeController,
                            node: controller.bikeNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.bikeController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 132.5.w,
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.polyester,
                            controller: controller.polyesterController,
                            node: controller.polyesterNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.polyesterController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
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
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.cotton,
                            controller: controller.cottonController,
                            node: controller.cottonNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.cottonController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 132.5.w,
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.jacket,
                            controller: controller.jacketController,
                            node: controller.jacketNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.jacketController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
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
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.socks,
                            controller: controller.sockController,
                            node: controller.sockNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.sockController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 132.5.w,
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.pants,
                            controller: controller.pantController,
                            node: controller.pantNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.pantController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
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
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.globes,
                            controller: controller.globeController,
                            node: controller.globeNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.globeController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 132.5.w,
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.sports,
                            controller: controller.sportController,
                            node: controller.sportNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.sportController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
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
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.skiCloth,
                            controller: controller.skiClothController,
                            node: controller.skiClothNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.skiClothController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 132.5.w,
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.swim,
                            controller: controller.swimController,
                            node: controller.swimNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.swimController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
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
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.smart,
                            controller: controller.smartController,
                            node: controller.smartNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.smartController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 132.5.w,
                          child: GearWidget.customFieldWithUnit(
                            subtitle: StringManager.tent,
                            controller: controller.tentController,
                            node: controller.tentNode,
                            onChanged: (value) async {
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                            onSelectedItemChanged: (int index) {
                              controller.tentController.text = '$index';
                              controller.calculateConversion();
                              controller.updateButtonState();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
