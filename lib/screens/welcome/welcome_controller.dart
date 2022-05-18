import 'package:get/get.dart';
import 'package:hm_service/local/localization_service.dart';

class WelcomeController extends GetxController{
  onChangeLanguage(){
    var currentLanguageCode = Get.locale!.languageCode;
    LocalizationService().changeLocale(currentLanguageCode == 'ar'?'en':'ar');
  }
}