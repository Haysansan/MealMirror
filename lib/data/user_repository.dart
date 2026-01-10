import 'package:mealmirror/domain/models/user.dart';

// Simple in-memory user repository for a single-user local app.
// User can sign up once. After that, no account changes allowed.
class UserRepository {
  static User? _currentUser;

  // Check if a user has already signed up.
  static bool hasUser() => _currentUser != null;

  // Get the current user (null if not signed up yet).
  static User? getUser() => _currentUser;

  // Get user's nickname for display (returns empty string if no user).
  static String getNickname() => _currentUser?.nickname ?? '';

  // Get user's username (returns empty string if no user).
  static String getUsername() => _currentUser?.username ?? '';

  // Sign up the user (one-time only).
  // Returns true if signup successful, false if user already exists.
  static Future<bool> signUp(String username, String nickname) async {
    final u = username.trim();
    final n = nickname.trim();

    // Validate inputs.
    if (u.isEmpty || n.isEmpty) return false;

    // If user already exists, don't allow signup again.
    if (_currentUser != null) return false;

    // Create and store the user.
    _currentUser = User(username: u, nickname: n, createdAt: DateTime.now());

    return true;
  }

  // Update nickname (allowed for the single user).
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

  // Reset the user (for development/testing only).
  static Future<void> reset() async {
    _currentUser = null;
  }
}
