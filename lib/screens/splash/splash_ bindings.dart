
import 'package:get/get.dart';
import 'package:hm_service/screens/splash/splash_controller.dart';
import 'package:hm_service/screens/splash/splash_repository.dart';

class SplashBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashRepository());
    Get.put(SplashController());
  }

}