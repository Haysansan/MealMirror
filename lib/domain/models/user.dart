// Simple User model for the single local user.
class User {
  final String username;
  final String nickname;
  final DateTime createdAt;

  const User({
    required this.username,
    required this.nickname,
    required this.createdAt,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() => {
    'username': username,
    'nickname': nickname,
    'createdAt': createdAt.toIso8601String(),
  };

  // Create User from Map.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      nickname: map['nickname'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
