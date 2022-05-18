import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/screens/admin/requests/requests_repository.dart';

class RequestsControllerList extends GetxController {
  ///repository *********************
  RequestsRepositoryList repository = Get.find();

  ///Data *************************
  var loading = false.obs;
  var updating = false.obs;
  var requests = <RequestData>[];

  ///listener *****************
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
  _fetchRequests() async {
    loading.value = true;
    requests = await repository.fetchRequests();
    loading.value = false;
  }
  Future<bool> _changeStatus (String status, DocumentReference reference)async{
    return await repository.changeStatus(reference, status);
  }

  @override
  void onInit() {
    _fetchRequests();
  }
}
