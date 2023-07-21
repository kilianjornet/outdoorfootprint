import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/api_manager.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/my_footprint/widget/my_footprint_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/widget_manager.dart';
import '../controllers/my_footprint_controller.dart';

class MyFootprintView extends GetView<MyFootprintController> {
  const MyFootprintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: WidgetManager.primaryAppBar(
          title: StringManager.myFootprint,
          type: AppBarType.primary,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 20.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WidgetManager.whiteCanvas(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyFootprintWidget.customLegend(
                          type: LegendType.home,
                        ),
                        MyFootprintWidget.customLegend(
                          type: LegendType.mobility,
                        ),
                        MyFootprintWidget.customLegend(
                          type: LegendType.gear,
                        ),
                        MyFootprintWidget.customLegend(
                          type: LegendType.others,
                        ),
                      ],
                    ),
                    AspectRatio(
                      aspectRatio: 2,
                      child: Obx(
                        () {
                          return Visibility(
                            visible: controller.isLoading.value,
                            child: MyFootprintWidget.barChart(
                              list: controller.list,
                              maxValue: controller.maxTotalKg,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                  ),
                  child: Text(
                    StringManager.currentYear,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: ColorManager.captionText,
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 240.h,
                      width: 240.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.white,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.primary.withOpacity(
                              0.5,
                            ),
                            spreadRadius: 1,
                            blurRadius: 15,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringManager.co2,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w400,
                              fontSize: 24.sp,
                              color: ColorManager.captionText,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () {
                                  return Text(
                                    '${controller.totalTon.value}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: ColorManager.button,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                StringManager.ton,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: ColorManager.button,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: WidgetManager.pieChart(
                        co2Home: controller.co2Home,
                        co2Mobility: controller.co2Mobility,
                        co2Gear: controller.co2Gear,
                        co2Food: controller.co2Food,
                      ),
                    ),
                  ],
                ),
                WidgetManager.whiteCanvas(
                  children: [
                    WidgetManager.totalData(
                      type: DataType.home,
                      total: controller.co2Home,
                    ),
                    WidgetManager.totalData(
                      type: DataType.mobility,
                      total: controller.co2Mobility,
                    ),
                    WidgetManager.totalData(
                      type: DataType.gear,
                      total: controller.co2Gear,
                    ),
                    WidgetManager.totalData(
                      type: DataType.others,
                      total: controller.co2Food,
                    ),
                    WidgetManager.totalData(
                      type: DataType.public,
                      total: controller.co2Public,
                    ),
                    Divider(
                      color: ColorManager.primary,
                      thickness: 1.h,
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringManager.total,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: ColorManager.labelText,
                            ),
                          ),
                          Row(
                            children: [
                              Obx(() {
                                return Text(
                                  '${controller.totalKg.value}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: ColorManager.displayText,
                                  ),
                                );
                              }),
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
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          return Text(
                            '${controller.totalTon.value}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: ColorManager.displayText,
                            ),
                          );
                        }),
                        Text(
                          ' ${StringManager.tonCo}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: ColorManager.labelText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    height: 8.h,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringManager.compareCarbon,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: ColorManager.titleText,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () async {
                      const url = ApiManager.perCapita;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    style: TextButton.styleFrom(),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.language, color: Color(0xFFED92A2)),
                          SizedBox(width: 10.0),
                          Text(StringManager.perCapitaUrl,
                              style: TextStyle(
                                  color: Color(0xFFA294C2),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ));
  }
}
