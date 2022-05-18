import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/helper/flash_helper.dart';
import 'package:hm_service/main.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/user_type.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/signin/signin_repository.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/util/collections.dart';

class SignInController extends GetxController {
  SignInRepository get repository => Get.find();

  ///Data ***********************************************
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  var loading = false.obs;
  final formKey = GlobalKey<FormState>();

  ///listener ***************************************
  onLoginAction() {
    if (formKey.currentState!.validate()) {
      _signInFirebase();
    }
  }

  onResetPassword() {
    if (validateEmail(email.text) != null) {
      FlashHelper.showTopFlash(
        "should".tr,
        bckColor: kRed,
      );
      return;
    }
    _sendEmailResetPassword();
  }

  ///logic ******************************************
  String? validateEmail(String? value) {
    if (value!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
            .hasMatch(value)) return 'enter_valid_email'.tr;
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'password_valid'.tr;
    }
    return null;
  }

  _signInFirebase() async {
    loading.value = true;
    var resource = await repository.signInWithEmailAndPassword(
        email: email.text, password: password.text);
    loading.value = false;

    if (resource) {
      try {
        var _client = await _fetchCurrentClient();

        if (_client != null) {
          pref.setUserType(_client.type);
          if (_client.type == UserType.admin.toString()) {
            Get.offAllNamed(Routes.homeAdmin);
          } else {
            Get.offAllNamed(Routes.userHome);
          }
        } else {
          pref.setUserType(UserType.technician.toString());
          Get.offAllNamed(Routes.technicianHome);
        }
      } catch (e) {
        pref.setUserType(UserType.technician.toString());
        Get.offAllNamed(Routes.technicianHome);
      }
    }
  }

  Future<Client?> _fetchCurrentClient() async {
    return await repository.fetchCurrentClient(FirebaseFirestore.instance
        .collection(Collections.clients)
        .doc(FirebaseAuth.instance.currentUser!.uid));
  }

  _sendEmailResetPassword() async {
    loading.value = true;
    var resource = await repository.resetPassword(email: email.text);
    loading.value = false;

    if (resource) {
      var client = await _fetchCurrentClient();
      if (client!.type == UserType.admin.toString()) {
        Get.offAllNamed(Routes.homeAdmin, arguments: client);
      }
    }
  }
}
