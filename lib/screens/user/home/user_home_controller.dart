import 'package:get/get.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/screens/user/home/user_home_repository.dart';

class UserHomeController extends GetxController {
  UserHomeRepository repository = Get.find();

  @override
  void onInit() {
    _fetchClient();
    _fetchService();
  }
  /// Data ****************************************
  var services = <Service>[];
  Client? client;
  var loading = false;

  /// logic ****************************************

 _fetchService()async{
   loading = true;
   services = await repository.fetchService();
   loading = false;
   update();
 }

  _fetchClient()async{
    client = await repository.fetchCurrentClient();
    update(['drawer']);
  }

}
