import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/user_type.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/signin/signin_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/base_text_field.dart';
import 'package:hm_service/widgets/buttons/base_text_button.dart';
import 'package:hm_service/widgets/loaders/loader_page.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: true,
        iconTheme: const IconThemeData(color: kGreyDark),
        elevation: 0,
        title: Text(
          'login'.tr,
          style: const TextStyle(
              color: kGreyDark, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: LoaderPage(
        loading: controller.loading,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'email'.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ).paddingOnly(bottom: 8)),
                BaseTextField(
                  controller: controller.email,
                  hintText: '${'enter'.tr} ${'email'.tr}',
                  validator: controller.validateEmail,
                ).paddingOnly(bottom: 20),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'password'.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ).paddingOnly(bottom: 8)),
                BaseTextField(
                  controller: controller.password,
                  hintText: '${'enter'.tr} ${'password'.tr}',
                  isPassword: true,
                  validator: controller.validatePassword,
                ).paddingOnly(bottom: Get.height * 0.15),
                BaseTextButton(
                  title: 'login'.tr,
                  radius: 12,
                  height: 45,
                  onPress: controller.onLoginAction,
                )
                    .paddingSymmetric(horizontal: Get.width * 0.15)
                    .paddingOnly(bottom: 10),
                InkWell(
                    onTap: () =>
                        Get.toNamed(Routes.signup, arguments: UserType.user),
                    child: Text(
                      'signup'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: kGreyDark),
                    ).paddingOnly(bottom: 10)),
                InkWell(
                  onTap: controller.onResetPassword,
                  child: Text(
                    'forgot_password'.tr.toUpperCase(),
                    style: const TextStyle(fontSize: 16, color: kGreyDark),
                  ).paddingOnly(bottom: 10),
                ),
              ],
            ).paddingSymmetric(horizontal: 20, vertical: 20),
          ),
        ),
      ),
    );
  }
}
