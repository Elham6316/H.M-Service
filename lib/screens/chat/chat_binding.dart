import 'package:get/get.dart';
import 'package:hm_service/screens/chat/chat_controller.dart';
import 'package:hm_service/screens/chat/chat_repository.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ChatRepository());
    Get.put(ChatController());
  }

}