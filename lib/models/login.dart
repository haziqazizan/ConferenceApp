import 'dart:convert';

//database function of login credential
class Login {
  final int? id;
  final String username;
  final String password;

  Login({
    this.id,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Login.fromJson(String source) => Login.fromMap(json.decode(source));

  @override
  String toString() =>
      'Login(id: $id, username: $username, password: $password)';
}
