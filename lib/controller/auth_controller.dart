import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_posyandu/components/navbottom.dart';
import 'package:mobile_posyandu/auth/login.dart';
import 'package:mobile_posyandu/model/user.dart';
import 'connect.dart';

class ApiConfig {
  static String apiUrl = apiConnect;

  void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }
}

class AuthController {
  static int? _noKk;
  int? getNoKk() => _noKk;

  static Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/login";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email_orang_tua': email, 'password_orang_tua': password},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        // Validasi struktur response
        if (jsonData['data'] != null && jsonData['data']['user'] != null) {
          try {
            UserData userData = UserData.fromJson(jsonData['data']['user']);
            _noKk = userData.noKk;

            print('Login successful, no_kk: $_noKk');
            print('User data: ${userData.namaIbu}');
            // ignore: use_build_context_synchronously
            _showMessageDialog(context, userData.namaIbu, userData);
          } catch (e) {
            print('Error parsing user data: $e');
            // ignore: use_build_context_synchronously
            _showLoginErrorDialog(context, 'Error parsing data user: $e');
          }
        } else {
          print('Invalid response structure');
          print('Data: ${jsonData['data']}');
          // ignore: use_build_context_synchronously
          _showLoginErrorDialog(context, 'Struktur response tidak valid');
        }
      } else {
        print('Login failed with status: ${response.statusCode}');
        // ignore: use_build_context_synchronously
        _showLoginErrorDialog(
          context,
          'Email atau password salah. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error: $e');
      // ignore: use_build_context_synchronously
      _showLoginErrorDialog(context, 'Terjadi kesalahan: $e');
    }
  }

  static Future<UserData?> dataProfile(BuildContext context) async {
    try {
      if (_noKk == null) {
        print('No KK is null');
        return null;
      }

      final responseData = await http.get(
        Uri.parse("${ApiConfig.apiUrl}/api/auth/dataProfile?no_kk=$_noKk"),
      );

      print('Profile response status: ${responseData.statusCode}');
      print('Profile response body: ${responseData.body}');

      if (responseData.statusCode == 200) {
        final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;

        if (jsonGet['user'] != null) {
          final userData = UserData.fromJson(
            jsonGet['user'] as Map<String, dynamic>,
          );
          return userData;
        } else {
          print('User data not found in response');
          return null;
        }
      } else {
        print('Failed to get profile with status: ${responseData.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  static Future<bool> updateProfile(
    BuildContext context,
    int noKk,
    String namaIbu,
    String namaAyah,
    String alamat,
    String telepon,
  ) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/updateProfile";
      final response = await http.put(
        Uri.parse(apiUrl),
        body: {
          'no_kk': noKk.toString(),
          'nama_ibu': namaIbu,
          'nama_ayah': namaAyah,
          'alamat': alamat,
          'telepon': telepon,
        },
      );

      print('Update profile status: ${response.statusCode}');
      print('Update profile response: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error Updating profile: $error');
      return false;
    }
  }

  static void showErrorUpdate(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Gagal',
      desc: 'Profil Gagal di Edit',
    ).show();
  }

  Future<void> logout(BuildContext context) async {
    _noKk = null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  static Future<void> register(
    BuildContext context, {
    required String noKk,
    required String nikIbu,
    required String namaIbu,
    required String nikAyah,
    required String namaAyah,
    required String alamat,
    required String telepon,
    required String email,
    required String golDarah,
    required String tempatLahir,
    required String tanggalLahir,
    required String password,
  }) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/register";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'no_kk': noKk,
          'nik_ibu': nikIbu,
          'nama_ibu': namaIbu,
          'nik_ayah': nikAyah,
          'nama_ayah': namaAyah,
          'alamat': alamat,
          'telepon': telepon,
          'email_orang_tua': email,
          'gol_darah_ibu': golDarah,
          'tempat_lahir_ibu': tempatLahir,
          'tanggal_lahir_ibu': tanggalLahir,
          'password_orang_tua': password,
        },
      );

      print('Register status: ${response.statusCode}');
      print('Register response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        _showSuccessDialog(context);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        // ignore: use_build_context_synchronously
        _showErrorDialog(context);
      }
    } catch (e) {
      print('Error: $e');
      // ignore: use_build_context_synchronously
      _showErrorDialog(context);
    }
  }

  static void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Registrasi Berhasil',
      desc: 'Akun Anda telah berhasil didaftarkan!',
    ).show();
  }

  static void _showErrorDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Registrasi Gagal',
      desc: 'Maaf, terjadi kesalahan saat melakukan registrasi.',
    ).show();
  }

  static Future<bool> checkEmail(BuildContext context, String email) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/check-email";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email_orang_tua': email},
      );

      print('Check email status: ${response.statusCode}');
      print('Check email response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final message = jsonData['message'] as String;
        return message == 'true';
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  static Future<void> changePassword(
    BuildContext context,
    String email,
    String newPassword,
  ) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/change-password";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email_orang_tua': email, 'new_password': newPassword},
      );

      print('Change password status: ${response.statusCode}');
      print('Change password response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'] as String;
        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: message,
          btnOkText: 'OK',
          btnOkOnPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ).show();
      } else {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'] as String;

        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Error',
          desc: message,
        ).show();
      }
    } catch (e) {
      print('Error: $e');
      AwesomeDialog(
        // ignore: use_build_context_synchronously
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'Gagal memperbarui password',
      ).show();
    }
  }
}

void _showMessageDialog(BuildContext context, String data, UserData userData) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: 'Login Successful',
    desc: 'Selamat Datang, $data!',
  ).show();

  Future.delayed(const Duration(seconds: 2), () {
    Get.off(() => NavigationButtom(userData: userData));
  });
}

void _showLoginErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Login Gagal',
    desc: message,
    btnOkOnPress: () {},
  ).show();
}
