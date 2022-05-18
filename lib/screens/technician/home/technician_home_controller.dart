import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/screens/technician/home/technician_home_repository.dart';

class TechnicianHomeController extends GetxController{
  ///repository **********************************
  TechnicianHomeRepository repository = Get.find();
  ///Data *********************
  Rx<Technician?> technician = Rx(null);
  var loading = false.obs;
  var updating = false.obs;
  var requests = <RequestData>[];

  ///listener *********************
  onLogout(){
    Get.find<AuthHelper>().logout();
  }

  onChangeStatus(RequestData request)async{
    if(request.isComplete) return;
    updating.value = true;
    var isChanged = await _changeStatus(request.requestIncoming,request.ref!);
    updating.value = false;

    if(isChanged){
      request.status = request.requestIncoming;
      update();
    }
  }
  ///logic *********************
  _fetchTechnician()async{
    technician.value = await repository.fetchCurrentTechnician();
  }

  _fetchMyRequests()async{
    loading.value = true;
    requests = await repository.fetchMyRequests();
    update();
    loading.value = false;
  }

  Future<bool> _changeStatus (String status, DocumentReference reference)async{
    return await repository.changeStatus(reference, status);
  }

  @override
  void onInit() {
    _fetchTechnician();
    _fetchMyRequests();
  }
}