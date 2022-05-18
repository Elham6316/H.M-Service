import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/main.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/model/user_type.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/signup/signup_repo.dart';
import 'package:hm_service/util/collections.dart';

class SignUpController extends GetxController {
  SignUpRepository get repository => Get.find();

  ///Data ***********************************************
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  Rx<List<Service>> services = Rx(<Service>[]);
  var loading = false.obs;
  UserType? type = Get.arguments;
  Service? selectService;
  final formKey = GlobalKey<FormState>();

  ///listener **************************************
  onUserTypeChange(UserType? type) {
    this.type = type!;
    update(['userType']);
  }

  onSignUp() {
    if (formKey.currentState!.validate()) {
      _createClient();
    }
  }

  onServiceSelect(String name) {
    selectService =
        services.value.where((element) => element.locale == name).first;
  }

  ///logic ******************************************
  String? validateEmail(String? value) {
    if (value!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
            .hasMatch(value)) return 'enter_valid_email'.tr;
    return null;
  }

  String? validateString(String? value) {
    if (value!.isEmpty) return '${'enter'.tr} ${'full_name'.tr}';
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'password_valid'.tr;
    }
    return null;
  }

  Client _currentClient() {
    return Client(
        fullName: fullName.text,
        email: email.text,
        password: password.text,
        type: type.toString());
  }

  Technician _currentTechnician() {
    return Technician(
        name: fullName.text,
        email: email.text,
        password: password.text,serviceId: selectService!.reference!.id);
  }

  _createClient() async {
    loading.value = true;
    if (type != UserType.technician) {
      var resource = await repository.createClient(_currentClient());
      loading.value = false;
      if (resource != null) {
        pref.setUserType(type.toString());
        if (type != null) {
          if (resource.type == UserType.admin.toString()) {
            Get.offAllNamed(Routes.homeAdmin);
          } else {
            Get.offAllNamed(Routes.userHome);
          }
        }
      }
    } else {
      var resource = await repository.createTechnician(_currentTechnician());
      loading.value = false;
      if(resource!=null){
        pref.setUserType(type.toString());
        Get.offAllNamed(Routes.technicianHome);
      }
    }
  }

  _fetchServices() async {
    services.value = await repository.fetchService();
    selectService =
        services.value.first;
  }

  @override
  void onInit() {
    _fetchServices();

  }
}
