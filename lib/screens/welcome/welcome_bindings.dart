import 'package:get/get.dart';
import 'package:hm_service/screens/welcome/welcome_controller.dart';

class WelcomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(WelcomeController());
  }

}
