import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class PreferenceUtil {
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async =>
      _prefs = await SharedPreferences.getInstance();

  static saveUser(User user) {
    setString("studentid", user.studentId);
    setString("nickname", user.nickname);
    setString("major", user.major);
    setString("gender", user.gender);
  }

  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  //get
  static bool? getBool(String key) => _prefs.getBool(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static String? getString(String key) => _prefs.getString(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  //deletes
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
