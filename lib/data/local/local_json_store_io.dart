import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'local_json_store_stub.dart';

class LocalJsonStoreBackendImpl implements LocalJsonStoreBackend {
  static const String _fileName = 'mealmirror_store.txt';

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}${Platform.pathSeparator}$_fileName');
  }

  @override
  Future<Map<String, Object?>> readAll() async {
    final file = await _file();
    if (!await file.exists()) return <String, Object?>{};

    try {
      final raw = await file.readAsString();
      if (raw.trim().isEmpty) return <String, Object?>{};

      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, Object?>{};
      return decoded.map((k, v) => MapEntry(k.toString(), v));
    } catch (_) {
      return <String, Object?>{};
    }
  }

  @override
  Future<void> writeAll(Map<String, Object?> data) async {
    final file = await _file();
    await file.parent.create(recursive: true);

    final tmp = File('${file.path}.tmp');
    const encoder = JsonEncoder.withIndent('  ');
    await tmp.writeAsString(encoder.convert(data));

    if (await file.exists()) {
      await file.delete();
    }

    await tmp.rename(file.path);
  }

  @override
  Future<String> debugLocation() async {
    return (await _file()).path;
  }
}
