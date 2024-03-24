import 'package:flutter/material.dart';
import 'package:posyandu/main.dart';
import 'package:posyandu/model/user.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:posyandu/components/navbottom.dart';
import 'package:posyandu/model/database_helper.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User? loggedInUser = User(email: '', password: '');
  final LocalDatabase localDb = LocalDatabase();
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _fetchLoggedInUser();
  }

  Future<void> _fetchLoggedInUser() async {
    loggedInUser = await localDb.getUserByEmail(widget.user.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F6ECD),
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF0F6ECD),
          ),
          onPressed: () {
            if (loggedInUser != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NavigationButtom(user: loggedInUser!)),
              );
            }
          },
        ),
        titleSpacing: 0,
      ),
      body:
          loggedInUser == null ? _buildLoadingIndicator() : _buildProfileBody(),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProfileBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            widget.user.namaIbu ?? 'Tidak tersedia',
            style: const TextStyle(
                fontSize: 30,
                color: Color(0xFF0F6ECD),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sembunyikan data'),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeTrackColor: const Color(0xFF8FD4FD),
                activeColor: const Color(0xFF0F6ECD),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildInfoCard(),
          const SizedBox(height: 20),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoItem('Email', widget.user.email),
              _buildInfoItem('NIK', widget.user.nikIbu ?? 'Tidak tersedia'),
              if (!isSwitched) ...[
                _buildInfoItem('Tempat Lahir',
                    widget.user.placeOfBirth ?? 'Tidak tersedia'),
                _buildInfoItem(
                    'Tanggal Lahir', widget.user.birthDate ?? 'Tidak tersedia'),
                _buildInfoItem(
                    'Alamat', widget.user.alamat ?? 'Tidak tersedia'),
                _buildInfoItem(
                    'Telepon', widget.user.telepon ?? 'Tidak tersedia'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 5),
        Text(subtitle),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {
            _showLogoutConfirmation();
          },
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text(
            'Logout',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F6ECD),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      title: 'Konfirmasi',
      desc: 'Apakah Anda yakin ingin logout?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _logout();
      },
    ).show();
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}
