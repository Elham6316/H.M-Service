import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/comment.dart';
import 'package:hm_service/screens/technician/comment/comment_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/base_text_field.dart';
import 'package:hm_service/widgets/buttons/base_text_button.dart';
import 'package:hm_service/widgets/loaders/loader.dart';
import 'package:hm_service/widgets/loaders/loader_page.dart';
import 'package:hm_service/widgets/star_rating.dart';

class CommentsScreen extends GetView<CommentController> {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kWhite,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kBlack),
          title: Text(
            'review'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kBlack,
              fontSize: 20,
            ),
          ),
        ),
        body: LoaderPage(
          loading: controller.sending,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder(
                init: controller,
                autoRemove: false,
                builder: (_) => Expanded(
                    child: controller.loading.value
                        ? const Center(
                            child: Loader(),
                          )
                        : controller.comments.isEmpty
                            ? Center(
                                child: Text(
                                  'no_review'.tr,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ).paddingSymmetric(horizontal: 20)
                            : ListView.builder(
                                reverse: controller.args.fromUser && !controller.isCommentBefore.value,
                                shrinkWrap: true,
                                itemCount: controller.comments.length,
                                itemBuilder: (context, i) {
                                  return _commentItem(controller.comments[i]).paddingOnly(top: 10);
                                })),
              ),
              const SizedBox(
                height: 5,
              ),

              // Obx(
              Obx(
                () => controller.isCommentBefore.value || !controller.args.fromUser
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: kGreyMedium),
                                borderRadius: BorderRadius.circular(12)),
                            child: StarRating(
                              rating: controller.rating.value,
                              iconSize: 30,
                              onRatingChanged: controller.onRatingChange,
                            ).paddingSymmetric(vertical: 10, horizontal: 10),
                          ).paddingOnly(bottom: 10),
                          BaseTextField(
                            controller: controller.review,
                            hintText: '${'enter'.tr} ${'review'.tr}',
                            maxLength: 5,
                          ).paddingOnly(bottom: 10),
                          BaseTextButton(
                            title: 'sending_review'.tr,
                            onPress: controller.onSendingReview,
                          ).paddingOnly(
                              bottom: 10,
                              left: Get.width * 0.15,
                              right: Get.width * 0.15)
                        ],
                      ),
              ).paddingSymmetric(horizontal: 20)
            ],
          ),
        ));
  }

  Widget _commentItem(Comment comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                comment.client!.fullName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 5,),
            Text(
              comment.createdTime,
              style: const TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ).paddingOnly(bottom: 8),
        StarRating(rating: comment.rating!.toDouble(),).paddingOnly(bottom: 8),


        Text(
          comment.text!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),

        Container(
          height: 1,
          width: Get.width,
          color: kGreyMedium,
        ).paddingSymmetric(vertical: 5)
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}
