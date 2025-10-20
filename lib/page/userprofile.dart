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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006BFA),
        title: const Text(
          'Profile',
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
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data != null) {
          userData = snapshot.data!;
          return _buildProfile(userData);
        } else {
          return const Center(child: Text('No Data'));
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
              decoration: const BoxDecoration(
                color: Color(0xFF006BFA),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userData.namaIbu,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        userData.noKk.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataAnak.length,
                      itemBuilder: (context, index) {
                        return _buildChildCard(dataAnak[index]);
                      },
                    ),
                  ),
            const SizedBox(height: 20),
            _buildEditButton(),
            const SizedBox(height: 20),
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
      backgroundColor = Colors.blue.shade300;
      iconColor = Colors.blue.shade400;
    } else {
      backgroundColor = Colors.pink.shade200;
      iconColor = Colors.pink.shade300;
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(20),
      width: 200,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: FaIcon(
              dataAnak['jenis_kelamin_anak'] == 'Laki-laki'
                  ? FontAwesomeIcons.child
                  : FontAwesomeIcons.childDress,
              color: iconColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            dataAnak['nama_anak'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 2),
          Text(
            'Anak ke-${dataAnak['anak_ke']}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 2),
          Text(
            dataAnak['jenis_kelamin_anak'].toString(),
            style: const TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfile(userData: userData, onUpdate: _updateProfile),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(right: 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: const Color(0xFF006BFA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            _showLogoutConfirmation(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(right: 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: const Color(0xFF006BFA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.logout,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
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
