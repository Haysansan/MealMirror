import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// SQLite-backed offline multi-user auth.
/// Table (users): username TEXT PRIMARY KEY, nickname TEXT, createdAt TEXT, is_current INTEGER
class AuthService {
  static const _dbName = 'auth.db';
  static const _tableUsers = 'users';
  static Database? _db;

  static Future<Database> _openDb() async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE $_tableUsers (
            username TEXT PRIMARY KEY,
            nickname TEXT,
            createdAt TEXT,
            is_current INTEGER DEFAULT 0
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  static Future<bool> signUp(
    String username,
    String nickname, {
    bool replace = false,
  }) async {
    final u = username.trim();
    final n = nickname.trim();
    if (u.isEmpty || n.isEmpty) return false;
    final db = await _openDb();
    final existing = await db.query(
      _tableUsers,
      columns: ['username'],
      where: 'username = ?',
      whereArgs: [u],
      limit: 1,
    );
    if (existing.isNotEmpty && !replace) return false;
    final now = DateTime.now().toIso8601String();
    await db.transaction((txn) async {
      await txn.update(_tableUsers, {'is_current': 0}, where: 'is_current = 1');
      await txn.insert(_tableUsers, {
        'username': u,
        'nickname': n,
        'createdAt': now,
        'is_current': 1,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
    return true;
  }

  static Future<bool> login(String username) async {
    final u = username.trim();
    if (u.isEmpty) return false;
    final db = await _openDb();
    final exists = await db.query(
      _tableUsers,
      columns: ['username'],
      where: 'username = ?',
      whereArgs: [u],
      limit: 1,
    );
    if (exists.isEmpty) return false;
    await db.transaction((txn) async {
      await txn.update(_tableUsers, {'is_current': 0}, where: 'is_current = 1');
      await txn.update(
        _tableUsers,
        {'is_current': 1},
        where: 'username = ?',
        whereArgs: [u],
      );
    });
    return true;
  }

  static Future<void> logout() async {
    final db = await _openDb();
    await db.update(_tableUsers, {'is_current': 0}, where: 'is_current = 1');
  }

  static Future<bool> isLoggedIn() async {
    final db = await _openDb();
    final rows = await db.query(
      _tableUsers,
      columns: ['username'],
      where: 'is_current = 1',
      limit: 1,
    );
    return rows.isNotEmpty;
  }

  static Future<String?> getCurrentUsername() async {
    final db = await _openDb();
    final rows = await db.query(
      _tableUsers,
      columns: ['username'],
      where: 'is_current = 1',
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final v = rows.first['username'];
    return v is String && v.isNotEmpty ? v : null;
  }

  static Future<String?> getCurrentNickname() async {
    final db = await _openDb();
    final rows = await db.query(
      _tableUsers,
      columns: ['nickname'],
      where: 'is_current = 1',
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final v = rows.first['nickname'];
    return v is String && v.isNotEmpty ? v : null;
  }

  static Future<Map<String, String>> listUsers() async {
    final db = await _openDb();
    final rows = await db.query(_tableUsers, orderBy: 'createdAt DESC');
    final out = <String, String>{};
    for (final r in rows) {
      final username = r['username'];
      final nickname = r['nickname'];
      if (username is String && username.isNotEmpty && nickname is String) {
        out[username] = nickname;
      }
    }
    return out;
  }

  static Future<bool> updateNickname(
    String username,
    String newNickname,
  ) async {
    final u = username.trim();
    final n = newNickname.trim();
    if (u.isEmpty || n.isEmpty) return false;
    final db = await _openDb();
    final updated = await db.update(
      _tableUsers,
      {'nickname': n},
      where: 'username = ?',
      whereArgs: [u],
    );
    return updated > 0;
  }

  static Future<bool> deleteUser(String username) async {
    final u = username.trim();
    if (u.isEmpty) return false;
    final db = await _openDb();
    final deleted = await db.delete(
      _tableUsers,
      where: 'username = ?',
      whereArgs: [u],
    );
    return deleted > 0;
  }

  static Future<void> clearAll() async {
    final db = await _openDb();
    await db.delete(_tableUsers);
  }
}
