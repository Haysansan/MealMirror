import 'dart:convert';

import 'package:web/web.dart' as web;

import 'local_json_store_stub.dart';

class LocalJsonStoreBackendImpl implements LocalJsonStoreBackend {
  // Web cannot write to an arbitrary on-disk file without user interaction.
  // We store a single JSON blob in localStorage under a filename-like key.
  static const String _storageKey = 'mealmirror_store.txt';
  static const String _legacyStorageKey = 'mealmirror_store';

  web.Storage? get _storage => web.window.localStorage;

  void _migrateIfNeeded() {
    final storage = _storage;
    if (storage == null) return;
    if (storage.getItem(_storageKey) != null) return;

    final legacy = storage.getItem(_legacyStorageKey);
    if (legacy == null || legacy.trim().isEmpty) return;

    storage.setItem(_storageKey, legacy);
    storage.removeItem(_legacyStorageKey);
  }

  Map<String, Object?> _readAllSync() {
    final storage = _storage;
    if (storage == null) return <String, Object?>{};

    _migrateIfNeeded();
    final raw = storage.getItem(_storageKey);
    if (raw == null || raw.trim().isEmpty) return <String, Object?>{};

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, Object?>{};
      return decoded.map((k, v) => MapEntry(k.toString(), v));
    } catch (_) {
      return <String, Object?>{};
    }
  }

  void _writeAllSync(Map<String, Object?> data) {
    final storage = _storage;
    if (storage == null) return;

    _migrateIfNeeded();
    // Pretty JSON makes DevTools inspection easier.
    const encoder = JsonEncoder.withIndent('  ');
    storage.setItem(_storageKey, encoder.convert(data));
  }

  @override
  Future<Map<String, Object?>> readAll() async => _readAllSync();

  @override
  Future<void> writeAll(Map<String, Object?> data) async => _writeAllSync(data);

  @override
  Future<String> debugLocation() async {
    return _storage == null
        ? 'localStorage(unavailable):$_storageKey'
        : 'localStorage:$_storageKey';
  }
}
