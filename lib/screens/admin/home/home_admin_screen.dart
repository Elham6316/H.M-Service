import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/admin/home/home_admin_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/theme/app_images.dart';

class HomeAdminScreen extends GetView<HomeAdminController> {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Image.asset(logo),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              InkWell(
                onTap: ()=> Get.toNamed(Routes.technicianList),
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kBlack),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: Get.width * 0.18,
                            ),
                            Icon(
                              Icons.person_outline,
                              size: Get.width * 0.18,
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 10),
                      Text(
                        'technician'.tr,
                        style: const TextStyle(
                            color: kBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: ()=> Get.toNamed(Routes.clientsList),
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kBlack),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: Get.width * 0.18,
                            ),
                            Icon(
                              Icons.person,
                              size: Get.width * 0.18,
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 10),
                      Text(
                        'clients'.tr,
                        style: const TextStyle(
                            color: kBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ).paddingOnly(bottom: 20),
          Row(
            children: [
              InkWell(
                onTap: ()=> Get.toNamed(Routes.requestsList),
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kBlack),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.workspaces_filled,
                              size: Get.width * 0.18,
                            ).paddingSymmetric(horizontal: Get.width * 0.09),

                          ],
                        ),
                      ).paddingOnly(bottom: 10),
                      Text(
                        'requests'.tr,
                        style: const TextStyle(
                            color: kBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: ()=> Get.find<AuthHelper>().logout(),
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kBlack),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              size: Get.width * 0.18,
                            ).paddingSymmetric(horizontal: Get.width * 0.09),
                          ],
                        ),
                      ).paddingOnly(bottom: 10),
                      Text(
                        'logout'.tr,
                        style: const TextStyle(
                            color: kBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
