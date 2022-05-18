import 'package:get/get.dart';
import 'package:hm_service/screens/signup/signup_controller.dart';
import 'package:hm_service/screens/signup/signup_repo.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SignUpRepository());
    Get.put(SignUpController());
  }

}