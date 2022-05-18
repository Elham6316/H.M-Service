import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/screens/admin/requests/requests_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/loaders/loader.dart';
import 'package:hm_service/widgets/loaders/loader_page.dart';
import 'package:hm_service/widgets/star_rating.dart';

class RequestsScreenList extends GetView<RequestsControllerList> {
  const RequestsScreenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimary,
        centerTitle: true,
        title: Text(
          'requests'.tr,
          style: const TextStyle(
              color: kWhite, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: LoaderPage(
        loading: controller.updating,
        child: GetBuilder(
          init: controller,
          autoRemove: false,
          builder: (_) => Obx(() => controller.loading.value
              ? const Center(
            child: Loader(),
          )
              : controller.requests.isEmpty
              ? const SizedBox()
              : SingleChildScrollView(
            child: Column(
              children: controller.requests
                  .map<Widget>((e) => _requestItem(e).paddingSymmetric(vertical: 5))
                  .toList(),
            ).paddingSymmetric(horizontal: 10, vertical: 10),
          )),
        ),
      ),
    );
  }

  Widget _requestItem(RequestData request) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: request.color),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '#${request.ref!.id.substring(0, 6)}',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: kPrimary),
              ),
              const SizedBox(
                width: 5,
              ),
              const Expanded(child: SizedBox()),
              Text(
                request.status!.tr,
                style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )
            ],
          ).paddingOnly(bottom: 10),
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: request.service!.icon!,
                placeholder: (context, url) => const Loader(),
                height: 40,
                width: 40,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                request.service!.locale,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              )
            ],
          ).paddingOnly(bottom: 5),
          Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kPrimary)),
                child: const Center(
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: kPrimary,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                request.strTime,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              )
            ],
          ).paddingOnly(bottom: 5),
          Container(
            height: 1,
            width: Get.width,
            color: request.color,
          ).paddingSymmetric(vertical: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.client!.fullName!,
                      style: const TextStyle(
                          fontSize: 16,
                          color: kBlack,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () => controller.onChangeStatus(request),
                child: Text(
                  request.requestIncoming.tr,
                  style: TextStyle(
                      color: request.colorIncoming,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
          Container(
            height: 1,
            width: Get.width,
            color: kGreyMedium,
          ).paddingSymmetric(vertical: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.technician!.name!,
                style: const TextStyle(
                    fontSize: 16,
                    color: kBlack,
                    fontWeight: FontWeight.bold),
              ).paddingOnly(bottom: 5),
              StarRating(
                rating: request.technician!.avgRate!,
              )
            ],
          ),

        ],
      ).paddingSymmetric(horizontal: 8, vertical: 8),
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}
