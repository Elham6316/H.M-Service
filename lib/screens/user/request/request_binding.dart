import 'package:get/get.dart';
import 'package:hm_service/screens/user/request/request_controller.dart';
import 'package:hm_service/screens/user/request/request_repository.dart';

class RequestBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RequestRepository());
    Get.put(RequestController());
  }

}