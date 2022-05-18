import 'package:get/get.dart';
import 'package:hm_service/screens/technician/home/technician_home_controller.dart';
import 'package:hm_service/screens/technician/home/technician_home_repository.dart';

class TechnicianHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(TechnicianHomeRepository());
    Get.put(TechnicianHomeController());
  }

}