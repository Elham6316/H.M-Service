import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/main.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/user_type.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/screens/splash/splash_repository.dart';
import 'package:hm_service/util/collections.dart';

class SplashController extends GetxController {
  /// Data ***************
  var logoOpacity = 0.0.obs; // widget opacity observable
  Worker? _worker;
  SplashRepository repository = Get.find();

  /// Lifecycle methods *************************

  @override
  void onReady() {
    _startTimer();
    logoOpacity.value += 1;
  }

  @override
  void onClose() {
    // Disposal of observables from a Controller are done automatically when the Controller is removed from memory
    //So no need to remove currentOpacity.obs subscribers ;) .
    _worker?.dispose();
  }

  /// Logic ***********************************************************

  //Wait 2 seconds then navigate to next page
  _startTimer() {
    _worker = debounce(logoOpacity, (_) => _finishSplash(),
        time: const Duration(seconds: 2));
  }

  Future<Client?> _fetchCurrentClient() async {
    return await repository.fetchCurrentClient(FirebaseFirestore.instance
        .collection(Collections.clients)
        .doc(FirebaseAuth.instance.currentUser!.uid));
  }

  _finishSplash() async{
    if(AuthHelper().isLoggedIn()){
      var type = pref.getUserType();
      if(type != null) {
        if (type.toString() == UserType.admin.toString()) {
          Get.offAllNamed(Routes.homeAdmin);
        } else if(type.toString() == UserType.user.toString()){
          Get.offAllNamed(Routes.userHome);
        }else{
          Get.offAllNamed(Routes.technicianHome);
        }
      }else{
        Get.offAllNamed(Routes.welcome);
      }
    }else{
      Get.offAllNamed(Routes.welcome);
    }
  }
}
