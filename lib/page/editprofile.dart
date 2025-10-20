import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobile_posyandu/model/user.dart';
import 'package:get/get.dart';
import 'package:mobile_posyandu/controller/auth_controller.dart';

class EditProfile extends StatefulWidget {
  final UserData userData;
  final Function(UserData updatedUserData) onUpdate;

  const EditProfile(
      {super.key, required this.userData, required this.onUpdate});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  bool _validateAlamat = false;
  bool _validateTelepon = false;

  late TextEditingController noKkController;
  late TextEditingController nikIbuController;
  late TextEditingController namaIbuController;
  late TextEditingController tempatLahirController;
  late TextEditingController tanggalLahirController;
  late TextEditingController golDarahIbuController;
  late TextEditingController nikAyahController;
  late TextEditingController namaAyahController;
  late TextEditingController alamatController;
  late TextEditingController teleponController;
  late TextEditingController emailController;

  UserData _getUpdatedUserData() {
    return UserData(
      noKk: int.parse(noKkController.text),
      nikIbu: nikIbuController.text,
      namaIbu: namaIbuController.text,
      tempatLahirIbu: tempatLahirController.text,
      tanggalLahirIbu: tanggalLahirController.text,
      golDarahIbu: golDarahIbuController.text,
      nikAyah: nikAyahController.text,
      namaAyah: namaAyahController.text,
      alamat: alamatController.text,
      telepon: teleponController.text,
      emailOrangTua: emailController.text,
      updatedAt: widget.userData.updatedAt,
      createdAt: widget.userData.createdAt,
    );
  }

  @override
  void initState() {
    super.initState();
    noKkController =
        TextEditingController(text: widget.userData.noKk.toString());
    nikIbuController = TextEditingController(text: widget.userData.nikIbu);
    namaIbuController = TextEditingController(text: widget.userData.namaIbu);
    tempatLahirController =
        TextEditingController(text: widget.userData.tempatLahirIbu);
    tanggalLahirController =
        TextEditingController(text: widget.userData.tanggalLahirIbu);
    golDarahIbuController =
        TextEditingController(text: widget.userData.golDarahIbu);
    nikAyahController = TextEditingController(text: widget.userData.nikAyah);
    namaAyahController = TextEditingController(text: widget.userData.namaAyah);
    alamatController = TextEditingController(text: widget.userData.alamat);
    teleponController = TextEditingController(text: widget.userData.telepon);
    emailController =
        TextEditingController(text: widget.userData.emailOrangTua);
  }

  @override
  void dispose() {
    noKkController.dispose();
    nikIbuController.dispose();
    namaIbuController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    golDarahIbuController.dispose();
    nikAyahController.dispose();
    namaAyahController.dispose();
    alamatController.dispose();
    teleponController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: noKkController,
                    enabled: false,
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
                      labelText: "Nomor Kartu Keluarga",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: nikIbuController,
                    enabled: false,
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
                      labelText: "NIK Ibu",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: namaIbuController,
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
                      labelText: "Nama Ibu",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: tempatLahirController,
                    enabled: false,
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
                      labelText: "Tempat Lahir",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: tanggalLahirController,
                    enabled: false,
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
                      labelText: "Tanggal Lahir",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: golDarahIbuController,
                    enabled: false,
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
                      labelText: "Golongan Darah Ibu",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: nikAyahController,
                    enabled: false,
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
                      labelText: "NIK Ayah",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: namaAyahController,
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
                      labelText: "Nama Ayah",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: alamatController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
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
                      labelText: "Alamat",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText:
                          _validateAlamat ? 'Alamat tidak boleh kosong' : null,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: teleponController,
                    maxLength: 13,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: "",
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
                      labelText: "Nomor Telepon",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText: _validateTelepon
                          ? 'Nomor telepon tidak boleh kosong'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    enabled: false,
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
                      labelText: "Email Orang Tua",
                      labelStyle: const TextStyle(
                        color: Color(0xFF006BFA),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                          _validateAlamat = alamatController.text.isEmpty;
                          _validateTelepon = teleponController.text.isEmpty;
                        });
                        if (_formKey.currentState!.validate()) {
                          UserData updatedUserData = _getUpdatedUserData();
                          bool isSuccess = await AuthController.updateProfile(
                            context,
                            updatedUserData.noKk,
                            updatedUserData.namaIbu,
                            updatedUserData.namaAyah,
                            updatedUserData.alamat,
                            updatedUserData.telepon,
                          );
                          if (isSuccess) {
                            widget.onUpdate(updatedUserData);
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              showSuccessUpdate(context, updatedUserData);
                            }
                          } else {
                            // ignore: use_build_context_synchronously
                            AuthController.showErrorUpdate(
                                // ignore: use_build_context_synchronously
                                context); // Menampilkan pesan kesalahan saat pembaruan gagal
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        backgroundColor: const Color(0xFF006BFA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSuccessUpdate(BuildContext context, UserData userData) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: 'Berhasil',
    desc: 'Profil Berhasil di Edit!',
    btnOkOnPress: () {
      Get.back();
    },
  ).show();
}