import '../local_json_store.dart';

class AppPreferences {
  static Future<void> init() async {
    // No-op: LocalJsonStore is lazy.
  }

  static Future<bool?> getBool(String key) => LocalJsonStore.getBool(key);

  static Future<void> setBool(String key, bool value) async {
    await LocalJsonStore.setBool(key, value);
  }
}
