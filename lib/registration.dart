import 'package:flutter/material.dart';
import 'package:posyandu/model/database_helper.dart';
import 'main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'model/user.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool rememberMeValue = false;
  bool isPasswordVisible = false;
  bool _validate = false;
  bool _validateNIK = false;
  bool _validateNama = false;
  bool _validateGender = false;
  final bool _validateTempatLahir = false;
  final bool _validateTanggalLahir = false;
  bool _validateAlamat = false;
  bool _validateTelepon = false;
  bool _validatePassword = false;
  TextEditingController birthDateController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  String selectedGender = 'Laki-laki';
  TextEditingController emailController = TextEditingController();
  TextEditingController nikIbuController = TextEditingController();
  TextEditingController namaIbuController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String nikIbu = nikIbuController.text;
      String namaIbu = namaIbuController.text;
      String gender = selectedGender;
      String placeOfBirth = placeOfBirthController.text;
      String birthDate = birthDateController.text;
      String alamat = alamatController.text;
      String telepon = teleponController.text;
      String password = passwordController.text;

      User newUser = User(
        email: emailController.text,
        nikIbu: nikIbuController.text,
        namaIbu: namaIbuController.text,
        gender: selectedGender,
        placeOfBirth: placeOfBirthController.text,
        birthDate: birthDateController.text,
        alamat: alamatController.text,
        telepon: teleponController.text,
        password: passwordController.text,
      );
      LocalDatabase().insertData(newUser);

      String dialogText = '''
        Email: $email
        NIK Ibu: $nikIbu
        Nama Ibu: $namaIbu
        Gender: $gender
        Place of Birth: $placeOfBirth
        Birth Date: $birthDate
        Alamat: $alamat
        Telepon: $telepon
        Password: $password
      ''';

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: 'Registration Data',
        desc: dialogText,
        btnOkText: 'Iya',
        btnCancelText: 'Tidak',
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Registrasi",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F6ECD),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan email anda...",
                      labelText: "Email",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 17,
                      ),
                      errorText: _validate ? 'Email tidak boleh kosong' : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: nikIbuController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan nik anda...",
                      labelText: "NIK",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText: _validateNIK ? 'NIK tidak boleh kosong' : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateNIK = true;
                        });
                        return 'NIK tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: namaIbuController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan nama anda...",
                      labelText: "Nama",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText:
                          _validateNama ? 'Nama tidak boleh kosong' : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateNama = true;
                        });
                        return 'Nama anda tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF0F6ECD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF0F6ECD)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 17,
                        ),
                        errorText: _validateGender
                            ? 'Jenis Kelamin harus dipilih'
                            : null,
                      ),
                      value: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                      items: ['Laki-laki', 'Perempuan'].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text(
                        "Pilih Jenis Kelamin",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0F6ECD),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            _validateGender = true;
                          });
                          return 'Jenis Kelamin harus dipilih';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: placeOfBirthController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tempat Lahir tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0F6ECD),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFF0F6ECD)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.5),
                              ),
                              hintText: "Tempat Lahir",
                              labelText: "Tempat Lahir",
                              labelStyle: const TextStyle(
                                color: Color(0xFF0F6ECD),
                                fontSize: 16,
                              ),
                              errorText: _validateTempatLahir
                                  ? 'Tempat Lahir tidak boleh kosong'
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: birthDateController,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tanggal Lahir tidak boleh kosong';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime currentDate = DateTime.now();
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: currentDate,
                                firstDate: DateTime(1900),
                                lastDate: currentDate,
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                        background: Colors.white,
                                        primary: Color(0xFF0F6ECD),
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (selectedDate != null &&
                                  selectedDate != currentDate) {
                                birthDateController.text = selectedDate
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                              }
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0F6ECD),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFF0F6ECD)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.5),
                              ),
                              hintText: "Tanggal Lahir",
                              labelText: "Tanggal Lahir",
                              labelStyle: const TextStyle(
                                color: Color(0xFF0F6ECD),
                                fontSize: 16,
                              ),
                              errorText: _validateTanggalLahir
                                  ? 'Tanggal Lahir tidak boleh kosong'
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: alamatController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan alamat anda...",
                      labelText: "Alamat",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText:
                          _validateAlamat ? 'Alamat tidak boleh kosong' : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateAlamat = true;
                        });
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: teleponController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan nomor telepon anda...",
                      labelText: "Telepon",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateTelepon = true;
                        });
                        return 'Nomor telepon tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan password anda...",
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 17),
                      errorText: _validatePassword
                          ? 'Password tidak boleh kosong'
                          : null,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF0F6ECD),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validatePassword = true;
                        });
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F6ECD),
                      ),
                      onPressed: registerButtonPressed,
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sudah memiliki akun? ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0F6ECD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}