import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/chat.dart';
import 'package:hm_service/model/chat_args.dart';
import 'package:hm_service/model/comment_args.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/user/my_request/my_request_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/loaders/loader.dart';
import 'package:hm_service/widgets/loaders/loader_page.dart';
import 'package:hm_service/widgets/star_rating.dart';

class MyRequestScreen extends GetView<MyRequestController> {
  const MyRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        centerTitle: true,
        title: Text(
          'my_requests'.tr,
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
              child: Column(
                children: controller.requests
                    .map<Widget>((e) => _requestItem(e))
                    .toList(),
              ),
            ),
          )),
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
              ),
              const SizedBox(
                width: 5,
              ),
             if(request.isComplete)
              InkWell(
                  onTap: () => Get.toNamed(Routes.comments,
                      arguments: CommentArgs(technician: request.technician!,fromUser: true)),
                  child: const Icon(
                    Icons.receipt,
                    color: kBlack,
                  )),
              if(request.isComplete)
              const SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () => Get.toNamed(Routes.chat,
                      arguments: ChatArgs(
                          Chat(
                              clientId: Get.find<AuthHelper>().clientRef().id,
                              techId: request.technician!.reference!.id),
                          request.technician!.name!)),
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
