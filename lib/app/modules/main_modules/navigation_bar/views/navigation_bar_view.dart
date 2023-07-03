import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/calculator_modules/add/views/add_view.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/home/views/home_view.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/my_footprint/views/my_footprint_view.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/color_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  const NavigationBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            HomeView(),
            AddView(),
            MyFootprintView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                0.5,
              ),
              spreadRadius: 10,
              blurRadius: 20,
              offset: const Offset(
                0,
                5,
              ),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              25.w,
            ),
            topRight: Radius.circular(
              25.w,
            ),
          ),
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) {
                controller.selectedIndex.value = index;
              },
              selectedLabelStyle: GoogleFonts.oswald(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
              selectedItemColor: ColorManager.button,
              unselectedItemColor: Colors.transparent,
              selectedFontSize: 16.sp,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.all(
                      8.h,
                    ),
                    width: 175.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.white,
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
                    child: SvgPicture.asset(
                      AssetManager.homeE,
                      height: 25.h,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    AssetManager.homeD,
                    height: 25.h,
                  ),
                  label: StringManager.home,
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.all(
                      8.h,
                    ),
                    width: 175.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.white,
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
                    child: SvgPicture.asset(
                      AssetManager.calculatorE,
                      height: 25.h,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    AssetManager.calculatorD,
                    height: 25.h,
                  ),
                  label: StringManager.calculator,
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.all(
                      8.h,
                    ),
                    width: 175.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.white,
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
                    child: SvgPicture.asset(
                      AssetManager.footprintE,
                      height: 25.h,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    AssetManager.footprintD,
                    height: 25.h,
                  ),
                  label: StringManager.myFootprint,
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    padding: EdgeInsets.all(
                      8.h,
                    ),
                    width: 175.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.white,
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
                    child: SvgPicture.asset(
                      AssetManager.profileE,
                      height: 25.h,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    AssetManager.profileD,
                    height: 25.h,
                  ),
                  label: StringManager.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
