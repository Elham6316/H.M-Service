import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/user/home/drawer_widget.dart';
import 'package:hm_service/screens/user/home/user_home_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/theme/app_images.dart';
import 'package:hm_service/widgets/loaders/loader.dart';

class UserHomeScreen extends GetView<UserHomeController> {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kBlack),
        centerTitle: true,
        title: Image.asset(
          logo,
          width: 200,
        ),
        backgroundColor: kWhite,
      ),
      drawer: GetBuilder(
          init: controller,
          autoRemove: false,
          id: 'drawer',
          builder: (_) => controller.client == null
              ? SizedBox(
                  width: Get.width * 0.75,
                )
              : DrawerWidget(
                  client: controller.client,
                )),
      body: GetBuilder(
          init: controller,
          autoRemove: false,
          builder: (_) => controller.loading
              ? const Center(
                  child: Loader(),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      spacing: 5,
                      children: controller.services
                          .map<Widget>(
                              (e) => _serviceItem(e).paddingOnly(bottom: 5))
                          .toList(),
                    ),
                  ),
                )),
    );
  }

  Widget _serviceItem(Service service) {
    return InkWell(
      onTap: ()=> Get.toNamed(Routes.userRequest,arguments: service),
      child: SizedBox(
        width: Get.width * 0.45,
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: service.icon!,
                  height: Get.width * 0.25,
                  width: Get.width * 0.25,
                  placeholder: (context, url) => const Loader(),
                ),
              ).paddingOnly(bottom: 5),
              Text(
                service.locale,
                style: const TextStyle(fontSize: 16, color: kBlack),
              )
            ],
          ).paddingSymmetric(horizontal: 8, vertical: 8),
        ),
      ),
    );
  }
}
