import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';

class MyFootprintWidget{
  MyFootprintWidget._();

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
    required String total,
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
              Text(
                total,
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: ColorManager.displayText,
                ),
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