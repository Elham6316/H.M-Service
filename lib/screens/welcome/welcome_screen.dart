import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/user_type.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/welcome/welcome_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/theme/app_images.dart';
import 'package:hm_service/widgets/buttons/base_text_button.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
              children: [

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Center(
              child: Image.asset(logo),
        ).paddingOnly(bottom: 30),
        BaseTextButton(
          title: 'login'.tr.toUpperCase(),
          radius: 8,
          onPress: () => Get.toNamed(Routes.signin),
        )
            .paddingSymmetric(horizontal: Get.width * 0.08)
            .paddingOnly(bottom: 15),
        BaseTextButton(
          title: 'signup'.tr.toUpperCase(),
          radius: 8,
          onPress: () => Get.toNamed(Routes.signup, arguments: UserType.user),
        )
            .paddingSymmetric(horizontal: Get.width * 0.08)
            .paddingOnly(bottom: 12),
        Padding(
          padding: EdgeInsetsDirectional.only(start: Get.width * 0.08),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: InkWell(
              onTap: () =>
                  Get.toNamed(Routes.signup, arguments: UserType.technician),
              child: Text(
                'sign_technician'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: kGreyDark,
                ),
              ),
            ),
          ),
        )
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 20),

                SafeArea(
                  child: BaseTextButton(
                    title: 'language'.tr.toUpperCase(),
                    radius: 8,
                    width: 120,
                    onPress: controller.onChangeLanguage,
                  ).paddingOnly(top: 20,left: 30,right: 20),
                ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}
