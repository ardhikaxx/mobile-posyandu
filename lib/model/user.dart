import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String email;
  String nikIbu;
  String namaIbu;
  String gender;
  String placeOfBirth;
  String birthDate;
  String alamat;
  String telepon;
  String password;

  User({
    required this.email,
    required this.nikIbu,
    required this.namaIbu,
    required this.gender,
    required this.placeOfBirth,
    required this.birthDate,
    required this.alamat,
    required this.telepon,
    required this.password,
  });

  get tanggalLahir => null;

  get nama => null;

  get nik => null;

  Map<String, dynamic> toJson() {
    return {
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

  static Future<User?> loginUser(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserData = prefs.getString('userData');

    if (storedUserData != null) {
      Map<String, dynamic> userData = jsonDecode(storedUserData);
      if (userData['email'] == email && userData['password'] == password) {
        return User.fromJson(userData);
      }
    }

    return null;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      nikIbu: json['nikIbu'],
      namaIbu: json['namaIbu'],
      gender: json['gender'],
      placeOfBirth: json['placeOfBirth'],
      birthDate: json['birthDate'],
      alamat: json['alamat'],
      telepon: json['telepon'],
      password: json['password'],
    );
  }
}
