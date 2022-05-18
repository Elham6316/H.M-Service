import 'package:get/get.dart';
import 'package:hm_service/screens/admin/home/home_admin_controller.dart';
import 'package:hm_service/screens/admin/home/home_admin_repository.dart';

class HomeAdminBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeAdminRepository());
    Get.put(HomeAdminController());
  }

}