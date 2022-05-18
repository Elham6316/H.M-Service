import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/initBindings.dart';
import 'package:hm_service/local/localization_service.dart';
import 'navigation/app_pages.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Tourism',
        initialRoute: AppPages.initial,
        locale: LocalizationService.getCurrentLocale(),
        translations: LocalizationService(),
        initialBinding:InitBinding(),
        fallbackLocale: LocalizationService.fallbackLocale,
        getPages: AppPages.routes);
  }
}
