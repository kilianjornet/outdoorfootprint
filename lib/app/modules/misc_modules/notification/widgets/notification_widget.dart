import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/data/utils/asset_manager.dart';

import '../../../../data/utils/color_manager.dart';

class NotificationWidget {
  NotificationWidget._();

  static Widget customNotification({
    required dynamic list,
  }) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        padding: EdgeInsets.only(
          bottom: 15.h,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),
              margin: EdgeInsets.only(
                top: 10.h,
              ),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(
                  10.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.boxShadow.withOpacity(
                      0.3,
                    ),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10.w,
                    ),
                    child: SvgPicture.asset(
                      AssetManager.notificationSnackBar,
                      width: 20.w,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list[index]['title'],
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: ColorManager.displayText,
                        ),
                      ),
                      Text(
                        list[index]['content'],
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
            ),
          );
        },
      );
    });
  }
}
