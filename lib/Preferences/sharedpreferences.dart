import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._constructor();
  static get instance => SharedPrefs._constructor();

  static late SharedPreferences _preferences;
  getpref() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //  ALL KEYS
  get userKey => "userKey";

  Future<dynamic> setSharedPrefs(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  String getSharedPrefs(String key) {
    return _preferences.getString(key) ?? "";
  }

  Future<bool> removSharedPrefs(String key) async {
    return await _preferences.remove(key);
  }
}
