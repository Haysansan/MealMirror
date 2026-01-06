import 'dart:convert';

import 'local_json_store.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUsername = 'username';
  static const String _keyNickname = 'nickname';

  static const String _stateKey = 'auth_state_v1';

  static Future<Map<String, Object?>> _loadState() async {
    final stored = await LocalJsonStore.getJson(_stateKey);
    if (stored is Map) {
      return stored.map((k, v) => MapEntry(k.toString(), v));
    }

    // Back-compat: older versions stored JSON as a string.
    if (stored is String && stored.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(stored);
        if (decoded is Map) {
          return decoded.map((k, v) => MapEntry(k.toString(), v));
        }
      } catch (_) {
        // fall through to default.
      }
    }

    return <String, Object?>{
      'version': 1,
      _keyIsLoggedIn: false,
      _keyUsername: null,
      _keyNickname: null,
      'users': <String, String>{},
    };
  }

  static Future<void> _saveState(Map<String, Object?> state) async {
    await LocalJsonStore.setJson(_stateKey, state);
  }

  static bool _boolFrom(Object? v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    return false;
  }

  static String? _stringFrom(Object? v) {
    if (v is String && v.isNotEmpty) return v;
    return null;
  }

  static Map<String, String> _usersFrom(Object? v) {
    if (v is Map) {
      final out = <String, String>{};
      for (final entry in v.entries) {
        final k = entry.key?.toString();
        final val = entry.value;
        if (k == null || k.isEmpty) continue;
        if (val is String && val.isNotEmpty) out[k] = val;
      }
      return out;
    }
    return <String, String>{};
  }

  static Future<void> _setCurrentUser({
    required String username,
    required String nickname,
  }) async {
    final state = await _loadState();
    state[_keyIsLoggedIn] = true;
    state[_keyUsername] = username;
    state[_keyNickname] = nickname;
    await _saveState(state);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final state = await _loadState();
    return _boolFrom(state[_keyIsLoggedIn]);
  }

  // Get current logged-in username
  static Future<String?> getCurrentUsername() async {
    final state = await _loadState();
    return _stringFrom(state[_keyUsername]);
  }

  // Get current user's nickname
  static Future<String?> getCurrentNickname() async {
    final state = await _loadState();
    return _stringFrom(state[_keyNickname]);
  }

  // Sign up - create new user locally
  static Future<bool> signUp(String username, String nickname) async {
    if (username.isEmpty || nickname.isEmpty) {
      return false;
    }

    final state = await _loadState();
    final users = _usersFrom(state['users']);
    // This app uses a lightweight local profile (no passwords).
    users[username] = nickname;
    state['users'] = users;
    state[_keyIsLoggedIn] = true;
    state[_keyUsername] = username;
    state[_keyNickname] = nickname;
    await _saveState(state);

    return true;
  }

  // Login - verify user exists locally
  static Future<bool> login(String username) async {
    if (username.isEmpty) {
      return false;
    }

    final state = await _loadState();
    final users = _usersFrom(state['users']);
    final nickname = users[username];
    if (nickname == null || nickname.isEmpty) {
      return false;
    }

    await _setCurrentUser(username: username, nickname: nickname);

    return true;
  }

  // Logout
  static Future<void> logout() async {
    final state = await _loadState();
    state[_keyIsLoggedIn] = false;
    state[_keyUsername] = null;
    state[_keyNickname] = null;
    await _saveState(state);
  }

  // Update nickname
  // static Future<bool> updateNickname(String newNickname) async {
  //   if (newNickname.isEmpty) {
  //     return false;
  //   }

  //   final prefs = await _prefs();
  //   final username = await getCurrentUsername();

  //   if (username == null) {
  //     return false;
  //   }

  //   await prefs.setString(_storedUserKey(username), newNickname);
  //   await prefs.setString(_keyNickname, newNickname);

  //   return true;
  // }

  // Delete account
  // static Future<void> deleteAccount() async {
  //   final prefs = await _prefs();
  //   final username = await getCurrentUsername();

  //   if (username != null) {
  //     await prefs.remove(_storedUserKey(username));
  //   }

  //   await logout();
  // }
}
