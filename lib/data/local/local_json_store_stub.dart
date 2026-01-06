abstract interface class LocalJsonStoreBackend {
  /// Reads the entire store as a JSON object map.
  ///
  /// Values must be JSON-compatible (`null`, `bool`, `num`, `String`, `List`, `Map`).
  Future<Map<String, Object?>> readAll();

  /// Writes the entire store as a JSON object map.
  Future<void> writeAll(Map<String, Object?> data);

  Future<String> debugLocation();
}

class LocalJsonStoreBackendUnsupported implements LocalJsonStoreBackend {
  @override
  Future<Map<String, Object?>> readAll() async {
    throw UnsupportedError('LocalJsonStore is not supported on this platform');
  }

  @override
  Future<void> writeAll(Map<String, Object?> data) async {
    throw UnsupportedError('LocalJsonStore is not supported on this platform');
  }

  @override
  Future<String> debugLocation() async {
    return 'unsupported';
  }
}

/// Default (non-io, non-web) fallback implementation.
///
/// This exists so conditional imports can always resolve a concrete type.
class LocalJsonStoreBackendImpl extends LocalJsonStoreBackendUnsupported {}
