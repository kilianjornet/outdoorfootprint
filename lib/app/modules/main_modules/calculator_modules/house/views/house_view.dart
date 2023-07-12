import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/house/widgets/house_widget.dart';

import '../../../../../data/utils/asset_manager.dart';
import '../../../../../data/utils/color_manager.dart';
import '../../../../../data/utils/string_manager.dart';
import '../../../../../data/utils/widget_manager.dart';
import '../controllers/house_controller.dart';

class HouseView extends GetView<HouseController> {
  const HouseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.house,
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
                StringManager.houseTitle,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: ColorManager.labelText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 230.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(
                              0.25,
                            ),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        onTapOutside: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        onChanged: (value) async {
                          controller.calculateTotalCarbon();
                          controller.updateButtonState(value);
                        },
                        onTap: () async {
                          WidgetManager.showNumberPicker(
                            controller: controller.adultController,
                            type: DropdownType.adult,
                            onSelectedItemChanged: (int index) {
                              controller.adultController.text = '${index + 1}';
                              controller.calculateTotalCarbon();
                            },
                          );
                        },
                        controller: controller.adultController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'^0')),
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
                        ],
                        focusNode: controller.adultNode,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: ColorManager.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ColorManager.button,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.w,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ColorManager.white,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.w,
                            ),
                          ),
                          suffixIcon: Container(
                            padding: EdgeInsets.only(
                              top: 19.h,
                              left: 10.w,
                              right: 15.w,
                              bottom: 17.h,
                            ),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: SvgPicture.asset(
                                AssetManager.arrowForward,
                                width: 7.w,
                              ),
                            ),
                          ),
                        ),
                        style: GoogleFonts.oswald(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.labelText,
                        ),
                        cursorColor: ColorManager.cursor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(
                              0.25,
                            ),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                          10.w,
                        ),
                      ),
                      child: Text(
                        StringManager.adult,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.houseHeat,
                children: [
                  HouseWidget.customFieldWithUnit(
                    type: UnitType.cubicMeter,
                    title: StringManager.naturalHeat,
                    subtitle: StringManager.enterQuantityUnit,
                    controller: controller.gasController,
                    node: controller.gasNode,
                    gasUnit: controller.gasUnit,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.gasController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                  HouseWidget.customFieldWithUnit(
                    type: UnitType.kgCoal,
                    title: StringManager.coal,
                    subtitle: StringManager.usualCoalWeight,
                    controller: controller.coalController,
                    node: controller.coalNode,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.coalController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                  HouseWidget.customFieldWithUnit(
                    type: UnitType.kg,
                    title: StringManager.wood,
                    controller: controller.woodController,
                    node: controller.woodNode,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.woodController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                  HouseWidget.customFieldWithUnit(
                    type: UnitType.litres,
                    title: StringManager.heatingOil,
                    subtitle: StringManager.enterQuantityUnit,
                    controller: controller.oilController,
                    node: controller.oilNode,
                    oilUnit: controller.oilUnit,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.oilController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                  HouseWidget.customFieldWithUnit(
                    type: UnitType.kwh,
                    title: StringManager.solarHeating,
                    controller: controller.solarController,
                    node: controller.solarNode,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.solarController.text = '0';
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
                title: StringManager.electricity,
                subtitle: StringManager.billInformation,
                children: [
                  Text(
                    StringManager.electricComposition,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                      color: ColorManager.displayText,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 132.5.w,
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.coal,
                          controller: controller.electricityCoalController,
                          node: controller.electricityCoalNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityCoalController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.oil,
                          controller: controller.electricityOilController,
                          node: controller.electricityOilNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityOilController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
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
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.naturalGas,
                          controller: controller.electricityGasController,
                          node: controller.electricityGasNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityGasController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.nuclear,
                          controller: controller.electricityNuclearController,
                          node: controller.electricityNuclearNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityNuclearController.text =
                                  '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
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
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.hydro,
                          controller: controller.electricityHydroController,
                          node: controller.electricityHydroNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityHydroController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.solar,
                          controller: controller.electricitySolarController,
                          node: controller.electricitySolarNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricitySolarController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
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
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.wind,
                          controller: controller.electricityWindController,
                          node: controller.electricityWindNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityWindController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.thermal,
                          controller: controller.electricityThermalController,
                          node: controller.electricityThermalNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityThermalController.text =
                                  '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
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
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.wood,
                          controller: controller.electricityWoodController,
                          node: controller.electricityWoodNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityWoodController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 132.5.w,
                        child: HouseWidget.customFieldWithUnit(
                          subtitle: StringManager.waste,
                          controller: controller.electricityWasteController,
                          node: controller.electricityWasteNode,
                          type: UnitType.percentage,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              controller.electricityWasteController.text = '0';
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            } else {
                              controller.calculateConversion();
                              controller.calculateComposition();
                              controller.calculateTotalCarbon();
                              controller.updateButtonState(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${StringManager.sumShare} :',
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: ColorManager.labelText,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            controller.sum.value == 100.0
                                ? ' ${controller.sum.value}'
                                : ' ${controller.sum.value} ${StringManager.sumError}',
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: controller.sum.value == 100.0
                                  ? ColorManager.successText
                                  : ColorManager.errorText,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  HouseWidget.customFieldWithUnit(
                    title: StringManager.electricityConsumption,
                    controller: controller.electricityController,
                    node: controller.electricityNode,
                    type: UnitType.kwh,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.electricityController.text = '0';
                        controller.calculateConversion();
                        controller.calculateComposition();
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateConversion();
                        controller.calculateComposition();
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                ],
              ),
              WidgetManager.titleWhiteCanvas(
                title: StringManager.internetData,
                children: [
                  HouseWidget.customFieldWithUnit(
                    subtitle: StringManager.personalData,
                    controller: controller.dataController,
                    node: controller.dataNode,
                    type: UnitType.gb,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.dataController.text = '0';
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      } else {
                        controller.calculateTotalCarbon();
                        controller.updateButtonState(value);
                      }
                    },
                  ),
                  HouseWidget.customFieldWithUnit(
                    subtitle: StringManager.homeModem,
                    controller: controller.modemController,
                    node: controller.modemNode,
                    type: UnitType.gb,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.modemController.text = '0';
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
                onTap: () async {
                  await controller.submitHouse();
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
