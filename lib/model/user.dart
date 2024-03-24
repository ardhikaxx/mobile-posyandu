import 'dart:convert';

class User {
  final int? id;
  final String email;
  final String? nikIbu;
  final String? namaIbu;
  final String? gender;
  final String? placeOfBirth;
  final String? birthDate;
  final String? alamat;
  final String? telepon;
  final String password;

  User({
    this.id,
    required this.email,
    this.nikIbu,
    this.namaIbu,
    this.gender,
    this.placeOfBirth,
    this.birthDate,
    this.alamat,
    this.telepon,
    required this.password,
  });

  get tanggalLahir => null;

  get nama => null;

  get nik => null;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "nikIbu": nikIbu,
      "namaIbu": namaIbu,
      "gender": gender,
      "placeOfBirth": placeOfBirth,
      "birthDate": birthDate,
      "alamat": alamat,
      "telepon": telepon,
      "password": password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      email: map['email'],
      nikIbu: map['nikIbu'],
      namaIbu: map['namaIbu'],
      gender: map['gender'],
      placeOfBirth: map['placeOfBirth'],
      birthDate: map['birthDate'],
      alamat: map['alamat'],
      telepon: map['telepon'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.encode(source) as Map<String, dynamic>);
}
