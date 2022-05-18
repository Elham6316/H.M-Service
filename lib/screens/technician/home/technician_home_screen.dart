import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/chat.dart';
import 'package:hm_service/model/chat_args.dart';
import 'package:hm_service/model/comment_args.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/technician/home/technician_home_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/theme/app_images.dart';
import 'package:hm_service/widgets/loaders/loader.dart';
import 'package:hm_service/widgets/loaders/loader_page.dart';
import 'package:hm_service/widgets/star_rating.dart';

class TechnicianHomeScreen extends GetView<TechnicianHomeController> {
  const TechnicianHomeScreen({Key? key}) : super(key: key);

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
      body: LoaderPage(
        loading: controller.updating,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => controller.technician.value != null
                  ? Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.technician.value!.name!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: kBlack,
                                  fontWeight: FontWeight.bold),
                            ).paddingOnly(bottom: 5),
                            const StarRating(
                              iconSize: 16,
                              color: kStar,
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                            onTap: () => Get.toNamed(Routes.comments,
                                arguments: CommentArgs(
                                    technician: controller.technician.value!)),
                            child: const Icon(
                              Icons.receipt,
                              color: kGreyMedium,
                              size: 20,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: controller.onLogout,
                          child: Text(
                            'logout'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                color: kRed,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  : const SizedBox(),
            ).paddingSymmetric(horizontal: 20),
            Container(
              height: 1,
              width: Get.width,
              color: kGreyMedium,
            ).paddingSymmetric(horizontal: 20).paddingOnly(top: 10),
            GetBuilder(
              init: controller,
              autoRemove: false,
              builder: (_) => Obx(
                () => Expanded(
                  child: controller.loading.value
                      ? const Center(child: Loader())
                      : controller.requests.isEmpty
                          ? Center(
                              child: Text(
                                'no_request'.tr,
                                style: const TextStyle(fontSize: 14),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: controller.requests
                                    .map<Widget>((e) => _requestItem(e))
                                    .toList(),
                              ).paddingSymmetric(horizontal: 20),
                            ),
                ),
              ),
            ),
          ],
        ).paddingOnly(top: 20),
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
              Expanded(child: Text(
                request.strTime,
                style:
                const TextStyle(fontSize: 14,),
              )),
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
              const SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () => Get.toNamed(Routes.chat,
                      arguments: ChatArgs(
                          Chat(
                              clientId: request.clientId!,
                              techId: request.technicianId),
                          request.client!.fullName!)),
                  child: const Icon(
                    Icons.chat,
                    color: kBlack,
                  ))
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 8, vertical: 8),
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}
