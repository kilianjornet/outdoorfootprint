import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/api_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/stacked_barchart.dart';
import '../../../../data/utils/string_manager.dart';
import '../../../../data/utils/widget_manager.dart';
import '../controllers/my_footprint_controller.dart';
import '../widget/footprintWidget.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: MyFootprintWidget.shadowCanvas(children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  const HorizontalBarChart(),
                  SizedBox(
                    height: 16.h,
                  ),
                  const HorizontalBarChart(),
                  SizedBox(
                    height: 16.h,
                  ),
                  const HorizontalBarChart(),
                  SizedBox(
                    height: 16.h,
                  ),
                  const HorizontalBarChart(),
                  SizedBox(
                    height: 16.h,
                  ),
                ]),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                StringManager.currentYear,
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 24.sp,
                  color: ColorManager.captionText,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
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
                          Text(
                            controller.totalTon,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: ColorManager.button,
                            ),
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
                  AspectRatio(
                    aspectRatio: 1,
                    child: MyFootprintWidget.pieChart(
                      co2Home: controller.co2Home,
                      co2Mobility: controller.co2Mobility,
                      co2Gear: controller.co2Gear,
                      co2Food: controller.co2Food,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: MyFootprintWidget.shadowCanvas(
                  children: [
                    MyFootprintWidget.totalData(
                      type: DataType.home,
                      total: '19.082',
                    ),
                    MyFootprintWidget.totalData(
                      type: DataType.mobility,
                      total: '19.082',
                    ),
                    MyFootprintWidget.totalData(
                      type: DataType.gear,
                      total: '19.082',
                    ),
                    MyFootprintWidget.totalData(
                      type: DataType.others,
                      total: '19.082',
                    ),
                    MyFootprintWidget.totalData(
                      type: DataType.public,
                      total: '19.082',
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
                              Text(
                                controller.totalKg,
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
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          controller.totalTon,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: ColorManager.displayText,
                          ),
                        ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
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
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ));
  }
}
