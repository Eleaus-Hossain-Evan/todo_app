import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KSharedPreference extends GetxController {
  static SharedPreferences? _pref;

  String isNew = "isNew";

  static Future init() async => _pref = await SharedPreferences.getInstance();

  Future<void> initializeData() async {
    await init();
  }

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  bool? getBool(String val) {
    if (_pref != null) {
      if (_pref!.getBool(val) != null) {
        return _pref!.getBool(val)!;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? getString(String val) {
    if (_pref != null) {
      if (_pref!.getString(val) != null) {
        return _pref!.getString(val)!;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  setString(String key, String val) {
    if (_pref != null) {
      _pref!.setString(key, val);
      update();
    }
  }

  setBool(String key, bool val) {
    if (_pref != null) {
      _pref!.setBool(key, val);
      update();
    }
  }
}
