import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/screens/user/request/request_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/base_text_field.dart';
import 'package:hm_service/widgets/buttons/base_text_button.dart';
import 'package:hm_service/widgets/loaders/loader.dart';
import 'package:hm_service/widgets/loaders/loader_page.dart';
import 'package:hm_service/widgets/star_rating.dart';

class RequestScreen extends GetView<RequestController> {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        centerTitle: true,
        title: Text(
          'send_request'.tr,
          style: const TextStyle(
              color: kWhite, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: LoaderPage(
        loading: controller.loading,
        child: GetBuilder(
          init: controller,
          autoRemove: false,
          builder: (_) => SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'what_problem'.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ).paddingOnly(bottom: 8)),
                  BaseTextField(
                    controller: controller.problem,
                    hintText: '${'enter'.tr} ${'what_problem'.tr}',
                    validator: controller.validateString,
                  ).paddingOnly(bottom: 20),
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'date_time'.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ).paddingOnly(bottom: 8)),
                  BaseTextField(
                    controller: controller.date,
                    hintText: '${'enter'.tr} ${'date_time'.tr}',
                    enabled: false,
                    onTap: controller.onShowDate,
                  ).paddingOnly(bottom: 20),
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'technician'.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ).paddingOnly(bottom: 8)),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(color: kGreyDark, width: 1.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Obx(
                      () => controller.loadTech.value
                          ? const Center(child: Loader())
                          : controller.technicians.isEmpty
                              ? Center(
                                  child: Text(
                                    'no_tec_available_now'.tr,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: controller.technicians
                                        .map<Widget>((e) =>
                                            _techItem(e, controller.selectTech!))
                                        .toList(),
                                  ),
                                ),
                    ),
                  ).paddingOnly(bottom: 20),
                  BaseTextButton(
                    title: 'send_request'.tr,
                    radius: 12,
                    height: 45,
                    borderColor: Colors.transparent,
                    onPress: controller.technicians.isEmpty ||
                            controller.selectTech == null
                        ? null
                        : controller.onSendRequest,
                  )
                      .paddingSymmetric(horizontal: Get.width * 0.15)
                      .paddingOnly(bottom: 10),
                ],
              ).paddingSymmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _techItem(Technician e, Technician selected) {
    return InkWell(
      onTap: () => controller.onTechSelect(e),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGreyMedium, width: 2)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name!,
                    style: const TextStyle(
                        fontSize: 16,
                        color: kBlack,
                        fontWeight: FontWeight.bold),
                  ).paddingOnly(bottom: 5),
                  StarRating(
                    rating: e.avgRate!,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            if (selected.reference == e.reference)
              const Icon(
                Icons.done,
                color: kGreen,
              )
          ],
        ).paddingSymmetric(horizontal: 5, vertical: 5),
      ).paddingSymmetric(horizontal: 5, vertical: 5),
    );
  }
}
