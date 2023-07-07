import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/home/controllers/home_controller.dart';

import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';

class PopDialogView extends GetView<HomeController> {
  const PopDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.openDialog.value = false;
        return true;
      },
      child: Dialog(
        insetPadding: EdgeInsets.only(
          bottom: 450.h,
          left: 20.w,
          right: 170.w,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 3,
            sigmaX: 3,
          ),
          child: Obx(
            () {
              return AnimatedSize(
                reverseDuration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.easeIn,
                duration: const Duration(
                  milliseconds: 250,
                ),
                child: controller.openDialog.value
                    ? Container(
                        height: 100.h,
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(
                            10.w,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Get.back();
                                await controller.logout();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 10.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      StringManager.logout,
                                      style: GoogleFonts.oswald(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: ColorManager.labelText,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      AssetManager.logout,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: ColorManager.labelText.withOpacity(
                                0.25,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 10.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    StringManager.deleteAccount,
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: ColorManager.errorText,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    AssetManager.delete,
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}
