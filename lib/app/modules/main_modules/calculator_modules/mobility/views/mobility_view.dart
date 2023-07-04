import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/mobility/widgets/mobility_widget.dart';

import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';
import '../controllers/mobility_controller.dart';

class MobilityView extends GetView<MobilityController> {
  const MobilityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.mobility,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetManager.titleWhiteCanvas(
                title: StringManager.car,
                children: [
                  MobilityWidget.customFieldWithUnit(
                    subtitle: StringManager.enterQuantityUnit,
                    quantityUnit: controller.quantityUnit,
                    controller: controller.quantityController,
                    node: controller.quantityNode,
                    type: UnitType.perKm,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.quantityController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                  MobilityWidget.customFieldWithUnit(
                    subtitle: StringManager.distance,
                    distanceUnit: controller.distanceUnit,
                    controller: controller.distanceController,
                    node: controller.distanceNode,
                    type: UnitType.liter,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.distanceController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.plane,
                children: [
                  MobilityWidget.customFieldWithUnit(
                    controller: controller.planeController,
                    node: controller.planeNode,
                    type: UnitType.hours,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.planeController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.bus,
                children: [
                  MobilityWidget.customFieldWithUnit(
                    subtitle: StringManager.enterQuantityUnit,
                    controller: controller.busController,
                    node: controller.busNode,
                    type: UnitType.km,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.busController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.train,
                children: [
                  MobilityWidget.customFieldWithUnit(
                    subtitle: StringManager.enterQuantityUnit,
                    controller: controller.trainController,
                    node: controller.trainNode,
                    type: UnitType.km,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.trainController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.helicopter,
                children: [
                  MobilityWidget.customFieldWithUnit(
                    controller: controller.helicopterController,
                    node: controller.helicopterNode,
                    type: UnitType.hoursFlight,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.helicopterController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                ],
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
