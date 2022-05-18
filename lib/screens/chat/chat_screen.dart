import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/local/localization_service.dart';
import 'package:hm_service/model/message.dart';
import 'package:hm_service/screens/chat/chat_controller.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/base_text_field.dart';

import '../../widgets/buttons/base_text_button.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        centerTitle: true,
        title: Text(
          controller.args.toName,
          style: const TextStyle(
              color: kWhite, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
                child: controller.messages.value.isEmpty
                    ? Center(
                        child: Text('${'write_something'.tr} ✍'.tr),
                      )
                    : ListView.builder(
                        itemCount: controller.messages.value.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return _messageItem(controller.messages.value[index])
                              .paddingOnly(bottom: 15)
                              .paddingSymmetric(horizontal: 10);
                        },
                      )),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseTextField(
                    controller: controller.message,
                    hintText: '${'enter'.tr} ${'message'.tr}',
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                BaseTextButton(
                  title: 'send'.tr,
                  radius: 8,
                  height: 50,
                  width: 80,
                  onPress: controller.onSendMessage,
                )
              ],
            ).paddingSymmetric(horizontal: 5, vertical: 5),
          ],
        ),
      ),
    );
  }

  Widget _messageItem(Message message) {
    if (message.from == Get.find<AuthHelper>().clientRef().id) {
      return Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          constraints: BoxConstraints(maxWidth: Get.width * 0.75),
          decoration: BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: LocalizationService.isRtl()
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
              bottomRight: !LocalizationService.isRtl()
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              message.message!,
              style: const TextStyle(color: kWhite, fontSize: 16),
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          constraints: BoxConstraints(maxWidth: Get.width * 0.75),
          decoration: BoxDecoration(
            border: Border.all(color: kPrimary),
            borderRadius: BorderRadius.only(
              topLeft: !LocalizationService.isRtl()
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
              topRight: LocalizationService.isRtl()
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
              bottomLeft: const Radius.circular(12),
              bottomRight: const Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              message.message!,
              style: const TextStyle(color: kPrimary, fontSize: 16),
            ),
          ),
        ),
      );
    }
  }
}
