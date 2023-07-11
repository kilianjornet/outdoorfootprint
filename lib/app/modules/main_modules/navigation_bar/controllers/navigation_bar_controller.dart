import 'package:get/get.dart';

import '../../../../data/services/main_services/profile_service.dart';
import '../../calculator_modules/add/views/add_view.dart';
import '../../home/views/home_view.dart';
import '../../my_footprint/views/my_footprint_view.dart';
import '../../profile/views/profile_view.dart';

class NavigationBarController extends GetxController {
  final profileService = ProfileService();
  var selectedIndex = 0.obs;
  var bottomPages = const [
    HomeView(),
    AddView(),
    MyFootprintView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
