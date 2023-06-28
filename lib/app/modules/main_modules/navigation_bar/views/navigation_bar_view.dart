import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  const NavigationBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.w),
            topRight: Radius.circular(15.w),
          ),
          // child: Obx(
          //   () => BottomNavigationBar(
          //     currentIndex: controller.selectedIndex.value,
          //     onTap: (index) {
          //       controller.selectedIndex.value = index;
          //     },
          //     selectedLabelStyle: GoogleFonts.roboto(
          //       fontWeight: FontWeight.w500,
          //       fontSize: 16.sp,
          //     ),
          //     unselectedLabelStyle: GoogleFonts.roboto(
          //       fontWeight: FontWeight.w500,
          //       fontSize: 16.sp,
          //     ),
          //     selectedItemColor: ColorManager.button,
          //     unselectedItemColor: ColorManager.unselectedLabel,
          //     unselectedFontSize: 16.sp,
          //     selectedFontSize: 16.sp,
          //     items: [
          //       BottomNavigationBarItem(
          //         activeIcon: Padding(
          //           padding: EdgeInsets.only(
          //             bottom: 5.h,
          //           ),
          //           child: SvgPicture.asset(
          //             AssetManager.listEnable,
          //             height: 25.h,
          //           ),
          //         ),
          //         icon: Padding(
          //           padding: EdgeInsets.only(
          //             bottom: 5.h,
          //           ),
          //           child: SvgPicture.asset(
          //             AssetManager.listDisable,
          //             height: 25.h,
          //           ),
          //         ),
          //         label: StringManager.listV,
          //       ),
          //       BottomNavigationBarItem(
          //         activeIcon: Padding(
          //           padding: EdgeInsets.only(
          //             bottom: 5.h,
          //           ),
          //           child: SvgPicture.asset(
          //             AssetManager.mapEnable,
          //             height: 25.h,
          //           ),
          //         ),
          //         icon: Padding(
          //           padding: EdgeInsets.only(
          //             bottom: 5.h,
          //           ),
          //           child: SvgPicture.asset(
          //             AssetManager.mapDisable,
          //             height: 25.h,
          //           ),
          //         ),
          //         label: StringManager.mapV,
          //       ),
          //       BottomNavigationBarItem(
          //         activeIcon: Padding(
          //           padding: EdgeInsets.only(
          //             bottom: 5.h,
          //           ),
          //           child: SvgPicture.asset(
          //             AssetManager.favouriteEnable,
          //             height: 25.h,
          //           ),
          //         ),
          //         icon: Padding(
          //           padding: EdgeInsets.only(
          //             bottom: 5.h,
          //           ),
          //           child: SvgPicture.asset(
          //             AssetManager.favouriteDisable,
          //             height: 25.h,
          //           ),
          //         ),
          //         label: StringManager.favourite,
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
