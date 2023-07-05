import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OffsetController extends GetxController {
  RxInt currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);
  var isEnable = true.obs;
  dynamic map = {
    'title': 'What a carbon offset?',
    'content':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.It is a long established fact that a reader will be by the readable content of a page when looking at its layout.',
  };

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
