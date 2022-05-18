import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hm_service/db/app_pref.dart';
import 'package:hm_service/helper/firebase_helper.dart';
import 'app.dart';


/// Global Vars ******************************
var pref = Get.put(AppPreferences());

/// Start Main ********************************
main() {
  initApp();
}


/// init app for both flavors
initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseHelper.init();
  await pref.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  /// run app
  runApp(const App());
}
