import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/screens/admin/technician/technician_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/loaders/loader.dart';
import 'package:hm_service/widgets/star_rating.dart';

class TechnicianScreenList extends GetView<TechnicianControllerList> {
  const TechnicianScreenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimary,
        centerTitle: true,
        title: Text(
          'technician'.tr,
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
            : controller.technicians.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
          child: Column(
            children: controller.technicians
                .map<Widget>((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ).paddingOnly(bottom: 8),
                StarRating(rating: e.avgRate!,iconSize: 20,),
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
