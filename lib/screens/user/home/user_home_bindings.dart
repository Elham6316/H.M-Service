import 'package:get/get.dart';
import 'package:hm_service/screens/user/home/user_home_controller.dart';
import 'package:hm_service/screens/user/home/user_home_repository.dart';

class UserHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(UserHomeRepository());
    Get.put(UserHomeController());
  }

}