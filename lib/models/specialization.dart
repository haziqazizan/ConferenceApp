import 'dart:convert';

//database function of register type
class Specialization {
  int? id;
  String area;

  Specialization({
    this.id,
    required this.area,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area,
    };
  }

  factory Specialization.fromMap(Map<String, dynamic> map) {
    return Specialization(
      id: map['id']?.toInt() ?? 0,
      area: map['area'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Specialization.fromJson(String source) =>
      Specialization.fromMap(json.decode(source));

  @override
  String toString() => 'Specialization(id: $id, area: $area)';
}
