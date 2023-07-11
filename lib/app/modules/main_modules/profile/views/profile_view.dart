import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_outdoor_footprint/app/data/utils/color_manager.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';
import 'package:my_outdoor_footprint/app/modules/main_modules/profile/widgets/profile_widget.dart';

import '../../../../data/utils/asset_manager.dart';
import '../../../../data/utils/string_manager.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.primaryAppBar(
        title: StringManager.profile,
        type: AppBarType.primary,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Form(
            key: controller.profileKey,
            child: Column(
              children: [
                ProfileWidget.profilePicture(
                  child: Obx(
                    () {
                      return controller.image.value != null
                          ? Image.file(
                              controller.selectedImage!,
                              fit: BoxFit.cover,
                              width: ScreenUtil().screenWidth,
                              height: ScreenUtil().screenHeight,
                            )
                          : controller.profileImage.value.isNotEmpty
                              ? Image.network(
                                  controller.profileImage.value,
                                  fit: BoxFit.cover,
                                  width: ScreenUtil().screenWidth,
                                  height: ScreenUtil().screenHeight,
                                )
                              : SvgPicture.asset(
                                  AssetManager.avatar,
                                  fit: BoxFit.cover,
                                  width: ScreenUtil().screenWidth,
                                  height: ScreenUtil().screenHeight,
                                );
                    },
                  ),
                  fromCamera: () async {
                    controller.pickImage(
                      imageSource: ImageSource.camera,
                    );
                  },
                  fromGallery: () async {
                    controller.pickImage(
                      imageSource: ImageSource.gallery,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 10.w,
                    bottom: 20.w,
                    left: 20.h,
                    right: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(
                      10.w,
                    ),
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
                  child: Column(
                    children: [
                      ProfileWidget.editFields(
                        controller: controller.firstNameController,
                        node: controller.firstNameNode,
                        type: FieldType.firstName,
                        onChanged: (value) async {
                          controller.updateButtonState(value);
                        },
                      ),
                      ProfileWidget.editFields(
                        controller: controller.lastNameController,
                        node: controller.lastNameNode,
                        type: FieldType.lastName,
                        onChanged: (value) async {
                          controller.updateButtonState(value);
                        },
                      ),
                      ProfileWidget.editFields(
                        controller: controller.emailController,
                        node: controller.emailNode,
                        type: FieldType.email,
                        onChanged: (value) async {
                          controller.updateButtonState(value);
                        },
                      ),
                      ProfileWidget.editFields(
                        controller: controller.countryController,
                        node: controller.countryNode,
                        type: FieldType.country,
                        onChanged: (value) async {
                          controller.updateButtonState(value);
                        },
                        onTap: () async {
                          final code =
                              await controller.countryPicker.showPicker(
                            context: Get.context!,
                            backgroundColor: ColorManager.primary,
                          );
                          if (code != null) {
                            controller.countryController.text = code.name;
                            controller.country.value = code.name;
                          }
                        },
                      ),
                      ProfileWidget.editFields(
                        controller: controller.numberController,
                        node: controller.numberNode,
                        type: FieldType.phoneNumber,
                        onChanged: (value) async {
                          controller.updateButtonState(value);
                        },
                      ),
                    ],
                  ),
                ),
                WidgetManager.primaryButton(
                  buttonName: StringManager.update,
                  isEnable: controller.isEnable,
                  onTap: () async {
                    await controller.updateProfile();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
