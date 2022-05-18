import 'package:get/get.dart';
import 'package:hm_service/screens/user/my_request/my_request_controller.dart';
import 'package:hm_service/screens/user/my_request/my_request_repository.dart';

class MyRequestBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MyRequestRepository());
    Get.put(MyRequestController());
  }

}