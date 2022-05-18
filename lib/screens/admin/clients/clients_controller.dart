import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/screens/admin/clients/clients_repository.dart';

class ClientsControllerList extends GetxController {
  ///repository *********************
  ClientsRepositoryList repository = Get.find();

  ///Data *************************
  var loading = false.obs;
  var clients = <Client>[];

  ///logic *********************
  _fetchClients() async {
    loading.value = true;
    clients = await repository.fetchClients();
    loading.value = false;
  }

  @override
  void onInit() {
    _fetchClients();
  }
}
