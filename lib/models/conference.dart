import 'dart:convert';

//database function of import 'dart:convert';

//database function of import 'dart:convert';

//database function of import 'dart:convert';

//database function of register info
class Conference {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final int SpecializationId;

  Conference({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.SpecializationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'SpecializationId': SpecializationId,
    };
  }

  factory Conference.fromMap(Map<String, dynamic> map) {
    return Conference(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      SpecializationId: map['SpecializationId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
  factory Conference.fromJson(String source) =>
      Conference.fromMap(json.decode(source));

  @override
  String toString() =>
      'Conference(id: $id, name: $name, email: $email, phone: $phone, role: $role, SpecializationId: $SpecializationId)';
}
