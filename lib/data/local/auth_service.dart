import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUsername = 'username';
  static const String _keyNickname = 'nickname';
  static const String _keyUsersPrefix = 'user_';

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Get current logged-in username
  static Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  // Get current user's nickname
  static Future<String?> getCurrentNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNickname);
  }

  // Sign up - create new user locally
  static Future<bool> signUp(String username, String nickname) async {
    if (username.isEmpty || nickname.isEmpty) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();

    // This app uses a lightweight local profile (no passwords).
    // If the user already exists, treat this as selecting that profile and
    // updating the nickname.
    await prefs.setString('$_keyUsersPrefix$username', nickname);

    // Set current user
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyNickname, nickname);

    return true;
  }

  // Login - verify user exists locally
  static Future<bool> login(String username) async {
    if (username.isEmpty) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();

    // Check if user exists
    final nickname = prefs.getString('$_keyUsersPrefix$username');
    if (nickname == null) {
      return false; // User doesn't exist
    }

    // Set logged in state
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyNickname, nickname);

    return true;
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyNickname);
  }

  // Update nickname
  static Future<bool> updateNickname(String newNickname) async {
    if (newNickname.isEmpty) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    final username = await getCurrentUsername();

    if (username == null) {
      return false;
    }

    await prefs.setString('$_keyUsersPrefix$username', newNickname);
    await prefs.setString(_keyNickname, newNickname);

    return true;
  }

  // Delete account
  static Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final username = await getCurrentUsername();

    if (username != null) {
      await prefs.remove('$_keyUsersPrefix$username');
    }

    await logout();
  }
}
