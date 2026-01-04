import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<void> setBool(String key, bool value) async {
    final prefs = _prefs ??= await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
