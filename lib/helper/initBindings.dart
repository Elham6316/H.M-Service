import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthHelper());
  }

}