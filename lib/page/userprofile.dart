import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_posyandu/auth/login.dart';
import 'package:mobile_posyandu/page/editprofile.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mobile_posyandu/controller/auth_controller.dart';
import 'package:mobile_posyandu/model/user.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:mobile_posyandu/controller/imunisasi_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  final UserData userData;
  const Profile({super.key, required this.userData});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserData userData;
  List<dynamic> dataAnak = [];

  @override
  void initState() {
    super.initState();
    userData = widget.userData;
    _fetchDataAnak();
  }

  Future<void> _fetchDataAnak() async {
    bool dataFetched = false;

    while (!dataFetched) {
      try {
        await ImunisasiController.fetchDataImunisasi(context);
        setState(() {
          dataAnak = ImunisasiController.imunisasiData;
          dataAnak.sort((a, b) => a['anak_ke'].compareTo(b['anak_ke']));
        });
        dataFetched = true;
      } catch (e) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  void _updateProfile(UserData updatedUserData) {
    setState(() {
      userData = updatedUserData;
    });
  }

  String _getNamaPendek(String? nama) {
    if (nama == null || nama.isEmpty) return '-';
    if (nama.length > 18) {
      List<String> words = nama.split(' ');
      if (words.length > 2) {
        return '${words[0]} ${words[1]}';
      }
    }
    return nama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006BFA),
        title: const Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: _buildProfileBody(),
    );
  }

  Widget _buildProfileBody() {
    return FutureBuilder<UserData?>(
      future: AuthController.dataProfile(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SkeletonLoader(
            builder: Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            items: 1,
            period: const Duration(seconds: 2),
            highlightColor: Colors.grey[100]!,
            direction: SkeletonDirection.ltr,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Kesalahan: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data != null) {
          userData = snapshot.data!;
          return _buildProfile(userData);
        } else {
          return const Center(child: Text('Tidak ada data'));
        }
      },
    );
  }

  Widget _buildProfile(UserData userData) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF006BFA),
                    Color(0xFF4B8BFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF006BFA).withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.12),
                            Colors.white.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    left: -20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.08),
                            Colors.white.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 3,
                            ),
                          ),
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 35,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            userData.namaIbu,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            userData.noKk.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            dataAnak.isEmpty
                ? const Column(
                    children: [
                      Text(
                        'Tidak ada data anak',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 175,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataAnak.length,
                      itemBuilder: (context, index) {
                        return _buildChildCard(dataAnak[index]);
                      },
                    ),
                  ),
            const SizedBox(height: 12),
            _buildEditButton(),
            const SizedBox(height: 12),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChildCard(Map<String, dynamic> dataAnak) {
    Color backgroundColor;
    Color iconColor;

    if (dataAnak['jenis_kelamin_anak'] == 'Laki-laki') {
      backgroundColor = Colors.blue.shade400;
      iconColor = Colors.blue.shade600;
    } else {
      backgroundColor = Colors.pink.shade400;
      iconColor = Colors.pink.shade600;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      width: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor,
            backgroundColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -25,
            right: -25,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -15,
            left: -15,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: FaIcon(
                      dataAnak['jenis_kelamin_anak'] == 'Laki-laki'
                          ? FontAwesomeIcons.child
                          : FontAwesomeIcons.childDress,
                      color: iconColor,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getNamaPendek(dataAnak['nama_anak']?.toString()),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Anak ke-${dataAnak['anak_ke']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dataAnak['jenis_kelamin_anak'].toString(),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 2,
        shadowColor: const Color(0xFF006BFA).withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfile(userData: userData, onUpdate: _updateProfile),
              ),
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF006BFA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 24,
                    color: Color(0xFF006BFA),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Edit Profil',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1D26),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF006BFA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFF006BFA),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 2,
        shadowColor: Colors.red.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            _showLogoutConfirmation(context);
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.logout,
                    size: 24,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1D26),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      title: 'Konfirmasi Logout',
      desc: 'Apakah Anda yakin ingin keluar?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        Get.off(() => LoginPage());
      },
    ).show();
  }
}
