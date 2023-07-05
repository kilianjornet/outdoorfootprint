import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/color_manager.dart';
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    StringManager.currentYear,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: ColorManager.captionText,
                    ),
                  ),
                  SvgPicture.asset(
                    AssetManager.barChart,
                    height: 500.h,
                    //height: 1000.h,
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
            ],
          ),
        ));
  }
}
