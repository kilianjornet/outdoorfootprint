import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';

import '../../../../data/utils/color_manager.dart';

class MyFootprintWidget {
  MyFootprintWidget._();

  static final betweenSpace = 0.2.w;
  static final style = GoogleFonts.oswald(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: ColorManager.displayText,
  );

  static Widget barChart({
    required dynamic list,
    required var maxValue,
  }) {
    return RotatedBox(
      quarterTurns: 1,
      child: Obx(
        () {
          return BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceEvenly,
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(),
                rightTitles: AxisTitles(
                    // sideTitles: SideTitles(
                    //   showTitles: true,
                    //   getTitlesWidget: leftTitles,
                    //   reservedSize: 30.w,
                    //   interval: 1,
                    // ),
                    ),
                topTitles: AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 40.w,
                  ),
                ),
              ),
              barTouchData: BarTouchData(enabled: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              barGroups: [
                generateGroupData(
                  x: 0,
                  co2Home: double.tryParse(
                      list.value[3]['calculation']['totalKgCo2OfHome']),
                  co2Mobility: double.tryParse(
                      list.value[3]['calculation']['totalKgCo2OfMobility']),
                  co2Gear: double.tryParse(
                      list.value[3]['calculation']['totalKgCo2OfGear']),
                  co2Food: double.tryParse(
                      list.value[3]['calculation']['totalKgCo2OfOthers']),
                ),
                generateGroupData(
                  x: 1,
                  co2Home: double.tryParse(
                      list.value[2]['calculation']['totalKgCo2OfHome']),
                  co2Mobility: double.tryParse(
                      list.value[2]['calculation']['totalKgCo2OfMobility']),
                  co2Gear: double.tryParse(
                      list.value[2]['calculation']['totalKgCo2OfGear']),
                  co2Food: double.tryParse(
                      list.value[2]['calculation']['totalKgCo2OfOthers']),
                ),
                generateGroupData(
                  x: 2,
                  co2Home: double.tryParse(
                      list.value[1]['calculation']['totalKgCo2OfHome']),
                  co2Mobility: double.tryParse(
                      list.value[1]['calculation']['totalKgCo2OfMobility']),
                  co2Gear: double.tryParse(
                      list.value[1]['calculation']['totalKgCo2OfGear']),
                  co2Food: double.tryParse(
                      list.value[1]['calculation']['totalKgCo2OfOthers']),
                ),
                generateGroupData(
                  x: 3,
                  co2Home: double.tryParse(
                      list.value[0]['calculation']['totalKgCo2OfHome']),
                  co2Mobility: double.tryParse(
                      list.value[0]['calculation']['totalKgCo2OfMobility']),
                  co2Gear: double.tryParse(
                      list.value[0]['calculation']['totalKgCo2OfGear']),
                  co2Food: double.tryParse(
                      list.value[0]['calculation']['totalKgCo2OfOthers']),
                ),
              ],
              maxY: maxValue.value + 50,
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 0,
                    color: ColorManager.black,
                    strokeWidth: 1.w,
                    strokeCap: StrokeCap.round,
                  ),
                  HorizontalLine(
                    y: (maxValue.value + 50) / 4.25,
                    color: ColorManager.black.withOpacity(0.5),
                    strokeWidth: 1.w,
                    strokeCap: StrokeCap.round,
                  ),
                  HorizontalLine(
                    y: (maxValue.value + 50) / 2,
                    color: ColorManager.black.withOpacity(0.5),
                    strokeWidth: 1.w,
                    strokeCap: StrokeCap.round,
                  ),
                  HorizontalLine(
                    y: (maxValue.value + 50) / 1.25,
                    color: ColorManager.black.withOpacity(0.5),
                    strokeWidth: 1.w,
                    strokeCap: StrokeCap.round,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static BarChartGroupData generateGroupData({
    required int x,
    required var co2Home,
    required var co2Mobility,
    required var co2Gear,
    required var co2Food,
  }) {
    final width = 8.h;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: co2Home,
          color: ColorManager.pieHome,
          width: width,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(ScreenUtil().screenWidth),
            bottomRight: Radius.circular(ScreenUtil().screenWidth),
          ),
        ),
        BarChartRodData(
          fromY: co2Home,
          toY: co2Home + co2Mobility,
          color: ColorManager.pieMobility,
          width: width,
          borderRadius: BorderRadius.zero,
        ),
        BarChartRodData(
          fromY: co2Home + co2Mobility,
          toY: co2Home + co2Mobility + co2Gear,
          color: ColorManager.pieGear,
          width: width,
          borderRadius: BorderRadius.zero,
        ),
        BarChartRodData(
          fromY: co2Home + co2Mobility + co2Gear,
          toY: co2Home +
              // betweenSpace +
              co2Mobility +
              // betweenSpace +
              co2Gear +
              // betweenSpace +
              co2Food,
          color: ColorManager.pieFood,
          width: width,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(ScreenUtil().screenWidth),
            topLeft: Radius.circular(ScreenUtil().screenWidth),
          ),
        ),
      ],
    );
  }

  static Widget bottomTitles(
    double value,
    TitleMeta meta,
  ) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '2020';
        break;
      case 1:
        text = '2021';
        break;
      case 2:
        text = '2022';
        break;
      case 3:
        text = '2023';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  static Widget leftTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '3';
        break;
      case 2:
        text = '6';
        break;
      case 3:
        text = '9';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  static Widget customLegend({required LegendType type}) {
    final width = 22.w;
    final height = 22.h;
    String title;
    Color color;

    switch (type) {
      case LegendType.home:
        title = StringManager.home;
        color = ColorManager.pieHome;
      case LegendType.mobility:
        title = StringManager.mobility;
        color = ColorManager.pieMobility;
      case LegendType.gear:
        title = StringManager.gear;
        color = ColorManager.pieGear;
      case LegendType.others:
        title = StringManager.others;
        color = ColorManager.pieFood;
    }
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 5.w,
            ),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(
                  6.w,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              color: ColorManager.labelText,
            ),
          )
        ],
      ),
    );
  }
}

enum LegendType {
  home,
  mobility,
  gear,
  others,
}
