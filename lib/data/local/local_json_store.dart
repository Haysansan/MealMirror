import 'local_json_store_stub.dart';
import 'local_json_store_stub.dart'
    as impl
    if (dart.library.io) 'local_json_store_io.dart'
    if (dart.library.html) 'local_json_store_web.dart';

/// Single-store API used by the rest of the app.
///
/// - Mobile/Desktop (IO): one JSON file in app documents directory.
/// - Web: one JSON string in `window.localStorage`.
class LocalJsonStore {
  static final LocalJsonStoreBackend _impl = impl.LocalJsonStoreBackendImpl();

  static Future<T> _withAll<T>(T Function(Map<String, Object?> data) fn) async {
    final data = await _impl.readAll();
    return fn(data);
  }

  static Future<void> _mutate(
    void Function(Map<String, Object?> data) fn,
  ) async {
    final data = await _impl.readAll();
    fn(data);
    await _impl.writeAll(data);
  }

  static Future<String?> getString(String key) async {
    final v = await getJson(key);
    return v is String ? v : null;
  }

  static Future<void> setString(String key, String value) =>
      setJson(key, value);

  static Future<Object?> getJson(String key) => _withAll((data) => data[key]);

  static Future<void> setJson(String key, Object? value) =>
      _mutate((data) => data[key] = value);

  static Future<bool?> getBool(String key) async {
    final v = await getJson(key);
    return v is bool ? v : null;
  }

  static Future<void> setBool(String key, bool value) => setJson(key, value);

  static Future<void> remove(String key) => _mutate((data) => data.remove(key));

  /// Human-readable location for debugging.
  ///
  /// - IO: full file path
  /// - Web: `localStorage:mealmirror_store.txt`
  static Future<String> debugLocation() => _impl.debugLocation();
}
