import 'package:get/get.dart';
import 'package:hm_service/screens/admin/clients/clients_controller.dart';
import 'package:hm_service/screens/admin/clients/clients_repository.dart';

class ClientsBindingList extends Bindings{
  @override
  void dependencies() {
    Get.put(ClientsRepositoryList());
    Get.put(ClientsControllerList());
  }

}