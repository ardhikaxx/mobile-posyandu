import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_posyandu/auth/change_new_password.dart';
import 'package:mobile_posyandu/auth/login.dart';
import 'package:mobile_posyandu/controller/auth_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    void showEmailAvailableDialog(BuildContext context) {
      // ignore: avoid_single_cascade_in_expression_statements
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Email Tersedia',
        desc: 'Email anda tersedia.',
      )..show().then((value) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });
    }

    void showEmailUnavailableDialog(BuildContext context) {
      // ignore: avoid_single_cascade_in_expression_statements
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Email Tidak Tersedia',
        desc: 'Email anda tidak tersedia atau belum didaftarkan.',
      )..show().then((value) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Lupa Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF006BFA),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Align(
                  child: Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: 210,
                      height: 210,
                      child: Image(
                        image: AssetImage('assets/icon-lupa password.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Silahkan masukkan email Anda untuk melakukan verifikasi',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF006BFA)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 45),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF006BFA),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF006BFA)),
                      ),
                      hintText: "Masukkan email anda...",
                      labelText: "Email",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 17),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006BFA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      final String email = emailController.text;
                      AuthController.checkEmail(context, email)
                          .then((isEmailAvailable) {
                        if (isEmailAvailable) {
                          showEmailAvailableDialog(context);
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewChangePassword(email: email),
                              ),
                            );
                          });
                        } else {
                          // Tampilkan dialog email tidak tersedia
                          showEmailUnavailableDialog(context);
                        }
                      });
                    },
                    child: const Text(
                      "Verifikasi",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFF006BFA)),
                      ),
                    ),
                    onPressed: () async {
                      Get.to(LoginPage());
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Color(0xFF006BFA),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}