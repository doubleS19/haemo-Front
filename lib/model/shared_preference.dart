import 'package:shared_preferences/shared_preferences.dart';
import 'user_model.dart';

class SharedPreference {
  static late SharedPreferences _pref;

  static Future<SharedPreferences> init() async =>
      _pref = await SharedPreferences.getInstance();

  static saveUser(User user) {
    setString("nickname", user.nickname);
    setString("major", user.major);
    setString("gender", user.gender);
  }

  static Future<bool> setBool(String key, bool value) async =>
      await _pref.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _pref.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _pref.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _pref.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _pref.setStringList(key, value);

  //get
  static bool? getBool(String key) => _pref.getBool(key);

  static double? getDouble(String key) => _pref.getDouble(key);

  static int? getInt(String key) => _pref.getInt(key);

  static String? getString(String key) => _pref.getString(key);

  static List<String>? getStringList(String key) => _pref.getStringList(key);

  //deletes
  static Future<bool> remove(String key) async => await _pref.remove(key);

  static Future<bool> clear() async => await _pref.clear();
}
