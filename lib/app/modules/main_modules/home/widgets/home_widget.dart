import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  static Widget pieChart({required List<double> dataPoints}) {
    return PieChart(
      PieChartData(
        sections: showingSections(),
        centerSpaceRadius: 75.w,
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 10.w,
      ),
    );
  }

  static List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final radius = 35.w;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: ColorManager.pieHome,
              value: 20,
              radius: radius,
              showTitle: false,
            );
          case 1:
            return PieChartSectionData(
              color: ColorManager.pieMobility,
              value: 30,
              showTitle: false,
              radius: radius,
            );
          case 2:
            return PieChartSectionData(
              color: ColorManager.pieGear,
              value: 25,
              showTitle: false,
              radius: radius,
            );
          case 3:
            return PieChartSectionData(
              color: ColorManager.pieFood,
              value: 15,
              showTitle: false,
              radius: radius,
            );
          default:
            throw Error();
        }
      },
    );
  }
}

enum DataType {
  home,
  mobility,
  gear,
  others,
  public,
}
