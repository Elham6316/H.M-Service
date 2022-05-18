import 'package:get/get.dart';
import 'package:hm_service/screens/signin/signin_controller.dart';
import 'package:hm_service/screens/signin/signin_repository.dart';

class SignInBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInRepository());
    Get.put(SignInController());
  }

}