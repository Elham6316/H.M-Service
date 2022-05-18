import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/screens/admin/clients/clients_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/loaders/loader.dart';

class ClientsScreenList extends GetView<ClientsControllerList> {
  const ClientsScreenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kWhite),
        backgroundColor: kPrimary,
        centerTitle: true,
        title: Text(
          'clients'.tr,
          style: const TextStyle(
              color: kWhite, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: GetBuilder(
        init: controller,
        autoRemove: false,
        builder: (_) => Obx(() => controller.loading.value
            ? const Center(
                child: Loader(),
              )
            : controller.clients.isEmpty
                ? const SizedBox()
                : SingleChildScrollView(
                    child: Column(
                      children: controller.clients
                          .map<Widget>((e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.fullName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ).paddingOnly(bottom: 8),
                                  Text(
                                    e.email!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Container(
                                    height: 1,
                                    width: Get.width,
                                    color: kGreyMedium,
                                  ).paddingSymmetric(vertical: 10)
                                ],
                              ).paddingSymmetric(vertical: 5))
                          .toList(),
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  )),
      ),
    );
  }
}
