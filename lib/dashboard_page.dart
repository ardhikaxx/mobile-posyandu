import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:posyandu/main.dart';
import 'model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  User? _loggedInUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F6ECD),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Image(
              image: AssetImage('logo.png'),
              width: 150,
              height: 150,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 22),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Text(
                  _loggedInUser != null
                      ? 'Selamat datang ${_loggedInUser!.namaIbu}!'
                      : 'Selamat datang di Dashboard!',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'Email: ${_loggedInUser?.email ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'NIK Ibu: ${_loggedInUser?.nikIbu ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Nama Ibu: ${_loggedInUser?.namaIbu ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Gender: ${_loggedInUser?.gender ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Place of Birth: ${_loggedInUser?.placeOfBirth ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Birth Date: ${_loggedInUser?.birthDate ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Alamat: ${_loggedInUser?.alamat ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Telepon: ${_loggedInUser?.telepon ?? ''}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.scale,
                      title: 'Konfirmasi',
                      desc: 'Apakah Anda yakin ingin logout?',
                      btnCancelText: 'Batal',
                      btnOkText: 'Ya',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ).show();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Ganti dengan warna sesuai kebutuhan
                  ),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white, // Warna ikon
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white, // Warna tulisan
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuButton('Dashboard', Icons.dashboard, 0),
              _buildMenuButton('Artikel', Icons.article, 1),
              _buildMenuButton('Grafik', Icons.insert_chart, 2),
              _buildMenuButton('Imunisasi', Icons.medical_services, 3),
              _buildMenuButton('Profil', Icons.person, 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon, int index) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _selectedIndex == index ? Colors.white : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              icon: Icon(
                icon,
                color: _selectedIndex == index
                    ? const Color(0xFF0F6ECD)
                    : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index
                  ? const Color(0xFF0F6ECD)
                  : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserData = prefs.getString('userData');

    if (storedUserData != null) {
      setState(() {
        _loggedInUser = User.fromJson(jsonDecode(storedUserData));
        // ignore: avoid_print
        print('User loaded: $_loggedInUser');
      });
    } else {
      // Display an AwesomeDialog for the error case
      AwesomeDialog(
        // ignore: use_build_context_synchronously
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error',
        desc: 'User data is not available.',
        btnCancelText: 'OK',
        btnCancelOnPress: () {
          Navigator.of(context).pop();
        },
      ).show();
    }
  }
}