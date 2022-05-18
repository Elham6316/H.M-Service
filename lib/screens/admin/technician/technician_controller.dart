import 'package:get/get.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/screens/admin/technician/technician_repository.dart';

class TechnicianControllerList extends GetxController {
  ///repository *********************
  TechnicianRepositoryList repository = Get.find();

  ///Data *************************
  var loading = false.obs;
  var technicians = <Technician>[];

  ///logic *********************
  _fetchTechnicians() async {
    loading.value = true;
    technicians = await repository.fetchTechnician();
    loading.value = false;
  }

  @override
  void onInit() {
    _fetchTechnicians();
  }
}
