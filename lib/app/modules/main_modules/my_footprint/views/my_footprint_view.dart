import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_footprint_controller.dart';

class MyFootprintView extends GetView<MyFootprintController> {
  const MyFootprintView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyFootprintView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyFootprintView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
