import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';

import 'app/data/utils/initializing_manager.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await InitializingManager.initialize();
  runApp(
    ScreenUtilInit(
      builder: (
        context,
        child,
      ) {
        return GetMaterialApp(
          title: StringManager.myOutdoorFootprint,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          defaultTransition: Transition.rightToLeftWithFade,
        );
      },
    ),
  );
}
