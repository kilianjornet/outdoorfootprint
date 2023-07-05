import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomView extends GetView {
  const CustomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Custom Content'),
    );
  }
}
