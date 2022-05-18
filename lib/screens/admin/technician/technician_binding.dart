import 'package:get/get.dart';
import 'package:hm_service/screens/admin/technician/technician_controller.dart';
import 'package:hm_service/screens/admin/technician/technician_repository.dart';

class TechnicianBindingList extends Bindings{
  @override
  void dependencies() {
    Get.put(TechnicianRepositoryList());
    Get.put(TechnicianControllerList());

  }

}