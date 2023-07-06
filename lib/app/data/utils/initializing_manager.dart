import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_outdoor_footprint/app/data/utils/string_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

class InitializingManager {
  InitializingManager._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    await dotenv.load(fileName: ".env");
    await subscribe();
  }

  static late StreamSubscription<ConnectivityResult> subscription;

  static ConnectivityResult previousResult = ConnectivityResult.none;

  static subscribe() {
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showNoInternetSnackBar();
      } else {
        previousResult = result;
      }

      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        handleConnectivityChange(result);
      });
    });
  }

  static void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none &&
        previousResult != ConnectivityResult.none) {
      showNoInternetSnackBar();
    } else if (result != ConnectivityResult.none &&
        previousResult == ConnectivityResult.none) {
      WidgetManager.customSnackBar(
        title: StringManager.connected,
        type: SnackBarType.success,
      );
    }
    previousResult = result;
  }

  static void showNoInternetSnackBar() {
    WidgetManager.customSnackBar(
      title: StringManager.noConnection,
      type: SnackBarType.error,
    );
  }
}
