import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/color_manager.dart';

class HomeWidget {
  HomeWidget._();

  static Widget shadowCanvas({
    required List<Widget> children,
  }) {
    return Container(
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
            color: ColorManager.black.withOpacity(
              0.25,
            ),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  static Widget totalData({
    required DataType type,
    required var total,
  }) {
    String assetPath;
    String title;

    switch (type) {
      case DataType.home:
        assetPath = AssetManager.home;
        title = StringManager.calculatorCat1;
        break;
      case DataType.mobility:
        assetPath = AssetManager.car;
        title = StringManager.calculatorCat2;
        break;
      case DataType.gear:
        assetPath = AssetManager.gear;
        title = StringManager.calculatorCat3;
        break;
      case DataType.others:
        assetPath = AssetManager.food;
        title = StringManager.calculatorCat4;
        break;
      case DataType.public:
        assetPath = AssetManager.publicService;
        title = StringManager.calculatorCat5;
        break;
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 30.w,
                child: SvgPicture.asset(
                  assetPath,
                  width: 15.w,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: ColorManager.labelText,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Obx(
                () {
                  return Text(
                    '${total.value}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: ColorManager.displayText,
                    ),
                  );
                },
              ),
              Text(
                ' ${StringManager.kgCo}',
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: ColorManager.labelText,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static Widget primaryButton({
    required String? buttonName,
    required var isEnable,
    required void Function()? onTap,
  }) {
    var isPressed = false.obs;
    return Obx(
      () => GestureDetector(
        onTapDown: (value) {
          if (isEnable.value == true) {
            isPressed.value = true;
          }
        },
        onTapUp: (value) {
          if (isEnable.value == true) {
            isPressed.value = false;
          }
        },
        onTap: isEnable.value ? onTap : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            margin: EdgeInsets.only(
              bottom: 20.h,
            ),
            decoration: BoxDecoration(
              color: isPressed.value
                  ? ColorManager.buttonPressed
                  : isEnable.value
                      ? ColorManager.button
                      : ColorManager.button.withOpacity(
                          0.4,
                        ),
              borderRadius: BorderRadius.circular(
                8.w,
              ),
              boxShadow: isEnable.value
                  ? [
                      BoxShadow(
                        color: ColorManager.button.withOpacity(
                          0.5,
                        ),
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ]
                  : null,
            ),
            child: Text(
              buttonName!,
              style: GoogleFonts.oswald(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget pieChart({
    required var co2Home,
    required var co2Mobility,
    required var co2Gear,
    required var co2Food,
  }) {
    return Obx(() {
      return PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: ColorManager.pieHome,
              value: co2Home.value,
              radius: 35.w,
              showTitle: false,
            ),
            PieChartSectionData(
              color: ColorManager.pieMobility,
              value: co2Mobility.value,
              radius: 35.w,
              showTitle: false,
            ),
            PieChartSectionData(
              color: ColorManager.pieGear,
              value: co2Gear.value,
              radius: 35.w,
              showTitle: false,
            ),
            PieChartSectionData(
              color: ColorManager.pieFood,
              value: co2Food.value,
              radius: 35.w,
              showTitle: false,
            ),
          ],
          centerSpaceRadius: 75.w,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 10.w,
        ),
      );
    });
  }
}

enum DataType {
  home,
  mobility,
  gear,
  others,
  public,
}
