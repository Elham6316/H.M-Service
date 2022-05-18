import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/screens/splash/splash_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/theme/app_images.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            color: kWhite,
          ),
          child: Center(
              child: Obx(() => AnimatedOpacity(
                  opacity: controller.logoOpacity.value,
                  duration: const Duration(milliseconds: 1100),
                  curve: Curves.linear,
                  child:Image.asset(logo))))),
    );
  }
}
