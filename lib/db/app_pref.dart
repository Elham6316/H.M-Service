import 'package:get_storage/get_storage.dart';

///Storage Keys
enum PreferenceKeys {keyAppLocal, userType}

class AppPreferences {
  //Data
  late GetStorage _storage;

  //init
  init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  ///App Locale **************************************************
  String? currentLocal() {
    return _storage.read(PreferenceKeys.keyAppLocal.toString()); // Language
  }

  setCurrentLocale(String? language) {
    _storage.write(PreferenceKeys.keyAppLocal.toString(), language);
  }

  String? getUserType() {
    return _storage.read(PreferenceKeys.userType.toString()); // Language
  }

  setUserType(String? type) {
    _storage.write(PreferenceKeys.userType.toString(), type);
  }

  ///Clear *******************************************************
  clear() async {
    String? local = currentLocal();
    await _storage.erase();
    setCurrentLocale(local);
  }
}
