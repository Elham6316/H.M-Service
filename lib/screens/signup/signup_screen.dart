import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/user_type.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/signup/signup_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/base_text_field.dart';
import 'package:hm_service/widgets/buttons/base_text_button.dart';
import 'package:hm_service/widgets/dropdown/dropdown_widget.dart';
import 'package:hm_service/widgets/loaders/loader_page.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

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
          'signup'.tr,
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
                ).paddingOnly(bottom: 20),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'full_name'.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ).paddingOnly(bottom: 8)),
                BaseTextField(
                  controller: controller.fullName,
                  hintText: '${'enter'.tr} ${'full_name'.tr}',
                  validator: controller.validateString,
                ).paddingOnly(bottom: 20),
                Obx(()=> controller.services.value.isNotEmpty&& controller.type == UserType.technician? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'services'.tr.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ).paddingOnly(bottom: 8)),
                    DropdownWidget(
                      onItemSelect: controller.onServiceSelect,
                      hint: 'services'.tr,
                      initSelect: controller.selectService!.locale,
                      items: controller.services.value.map((e) => e.locale).toList(),
                      tag: 'services',
                    ),
                  ],
                ):const SizedBox()).paddingOnly(bottom: Get.height * 0.15),

                BaseTextButton(
                  title: 'signup'.tr,
                  radius: 12,
                  height: 45,
                  onPress: controller.onSignUp,
                )
                    .paddingSymmetric(horizontal: Get.width * 0.15)
                    .paddingOnly(bottom: 10),
                InkWell(
                    onTap: () => Get.toNamed(Routes.signin),
                    child: Text(
                      'already_have_account'.tr.toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: kGreyDark),
                    ).paddingOnly(bottom: 10)),
              ],
            ).paddingSymmetric(horizontal: 20, vertical: 20),
          ),
        ),
      ),
    );
  }
}
