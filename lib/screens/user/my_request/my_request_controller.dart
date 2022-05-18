import 'package:get/get.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/screens/user/my_request/my_request_repository.dart';

class MyRequestController extends GetxController{
  MyRequestRepository repository = Get.find();

  @override
  void onInit() {
    _fetchRequests();
  }

  ///Data *********************************************
  var requests = <RequestData>[];
  var loading = false.obs;



  ///logic **********************************************
  _fetchRequests()async{
    loading.value = true;
    requests =await repository.fetchRequests();
    update();
    loading.value = false;
  }

}