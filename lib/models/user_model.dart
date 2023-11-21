import 'dart:convert';

User userFromJson(String str) =>
    User.fromJson(json.decode(str) as Map<String, dynamic>);

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String username;
  final String password;

  User({
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"] as String,
      password: json["password"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
