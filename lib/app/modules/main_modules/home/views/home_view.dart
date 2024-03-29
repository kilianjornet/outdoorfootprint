import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/home/views/pop_dialog_view.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/home/widgets/home_widget.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/color_manager.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.home,
        type: AppBarType.home,
        dialog: const PopDialogView(),
        openDialog: controller.openDialog,
        child: Obx(
          () {
            return controller.profileImage.value.isNotEmpty
                ? Image.network(
                    controller.profileImage.value,
                    fit: BoxFit.cover,
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight,
                  )
                : SvgPicture.asset(
                    AssetManager.avatar,
                    fit: BoxFit.cover,
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight,
                  );
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 20.w,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 5.h,
                ),
                child: Obx(
                  () {
                    return Text(
                      '${StringManager.hello}, ${controller.firstName.value}',
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        color: ColorManager.displayText,
                      ),
                    );
                  },
                ),
              ),
              Text(
                StringManager.welcomeText,
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: ColorManager.captionText,
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
                            Obx(() {
                              return Text(
                                '${controller.totalTon.value}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: ColorManager.button,
                                ),
                              );
                            }),
                            Text(
                              ' ${StringManager.ton}',
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
              HomeWidget.primaryButton(
                buttonName: StringManager.offsetEmission,
                isEnable: controller.isEnable[0],
                onTap: () async {
                  await Get.toNamed(
                    '/offset',
                  );
                },
              ),
              HomeWidget.primaryButton(
                buttonName: StringManager.tipsFootprint,
                isEnable: controller.isEnable[1],
                onTap: () async {
                  await Get.toNamed(
                    '/tips',
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 5.h,
                ),
                child: Text(
                  StringManager.homeTitle,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    color: ColorManager.displayText,
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
