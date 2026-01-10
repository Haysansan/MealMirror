import 'package:mealmirror/domain/models/user.dart';

// In-memory repository for a single local user (one-time signup).
class UserRepository {
  static User? _currentUser;

  static bool hasUser() => _currentUser != null;

  static User? getUser() => _currentUser;

  static String getNickname() => _currentUser?.nickname ?? '';

  static String getUsername() => _currentUser?.username ?? '';

  // One-time signup. Returns false if user already exists or input invalid.
  static Future<bool> signUp(String username, String nickname) async {
    final u = username.trim();
    final n = nickname.trim();

    if (u.isEmpty || n.isEmpty) return false;
    if (_currentUser != null) return false;

    _currentUser = User(username: u, nickname: n, createdAt: DateTime.now());

    return true;
  }

  // Update nickname for the existing user.
  static Future<bool> updateNickname(String newNickname) async {
    final n = newNickname.trim();
    if (n.isEmpty || _currentUser == null) return false;

    _currentUser = User(
      username: _currentUser!.username,
      nickname: n,
      createdAt: _currentUser!.createdAt,
    );

    return true;
  }

  // Development/testing only.
  static Future<void> reset() async {
    _currentUser = null;
  }
}
