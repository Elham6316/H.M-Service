import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/chat_args.dart';
import 'package:hm_service/model/message.dart';
import 'package:hm_service/screens/chat/chat_repository.dart';

class ChatController extends GetxController {
  ChatRepository repository = Get.find();

  @override
  void onInit() {
    _checkIfExist();
  }

  @override
  void onClose() {
    subscription!.cancel();
  }

  ///Data ***************************************
  ChatArgs args = Get.arguments;
  var isCreatedDone = false.obs;
  StreamSubscription? subscription;
  TextEditingController message = TextEditingController();
  var messages = Rx(<Message>[]);

  ///listener *****************************************
  onSendMessage() {
    if(message.text.isEmpty) return;
    _sendMessage();
  }

  ///logic *************************************
  _checkIfExist() async {
    isCreatedDone.value = await repository.checkIfRoomExist(args.chat);
    if (isCreatedDone.value) {
      _listenToMessages();
    }
  }

  _listenToMessages() {
    subscription = repository.listenToMessages(args.chat).listen((data) {
      messages.value = data;
    });
  }

  _sendMessage() async {
    var res = await repository.sendMessage(
        args.chat,
        Message(
            from: Get.find<AuthHelper>().clientRef().id,
            message: message.text));

    if(res) message.clear();
  }
}
