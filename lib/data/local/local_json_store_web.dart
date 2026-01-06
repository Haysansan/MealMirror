import 'dart:convert';
import 'dart:html' as html;

import 'local_json_store_stub.dart';

class LocalJsonStoreBackendImpl implements LocalJsonStoreBackend {
  // Web cannot write to an arbitrary on-disk file without user interaction.
  // We store a single JSON blob in localStorage under a filename-like key.
  static const String _storageKey = 'mealmirror_store.txt';
  static const String _legacyStorageKey = 'mealmirror_store';

  void _migrateIfNeeded() {
    if (html.window.localStorage.containsKey(_storageKey)) return;

    final legacy = html.window.localStorage[_legacyStorageKey];
    if (legacy == null || legacy.trim().isEmpty) return;

    html.window.localStorage[_storageKey] = legacy;
    html.window.localStorage.remove(_legacyStorageKey);
  }

  Map<String, Object?> _readAllSync() {
    _migrateIfNeeded();
    final raw = html.window.localStorage[_storageKey];
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
    _migrateIfNeeded();
    // Pretty JSON makes DevTools inspection easier.
    const encoder = JsonEncoder.withIndent('  ');
    html.window.localStorage[_storageKey] = encoder.convert(data);
  }

  @override
  Future<Map<String, Object?>> readAll() async => _readAllSync();

  @override
  Future<void> writeAll(Map<String, Object?> data) async => _writeAllSync(data);

  @override
  Future<String> debugLocation() async {
    return 'localStorage:$_storageKey';
  }
}
