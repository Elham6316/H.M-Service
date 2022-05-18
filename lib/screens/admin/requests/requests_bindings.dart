import 'package:get/get.dart';
import 'package:hm_service/screens/admin/requests/requests_controller.dart';
import 'package:hm_service/screens/admin/requests/requests_repository.dart';

class RequestsBindingList extends Bindings{
  @override
  void dependencies() {
    Get.put(RequestsRepositoryList());
    Get.put(RequestsControllerList());

  }

}