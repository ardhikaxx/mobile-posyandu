import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_posyandu/page/detail_imunisasi.dart';

class CardImunisasi extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const CardImunisasi({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color iconColor;

    if (dataAnak['jenis_kelamin_anak'] == 'Laki-laki') {
      backgroundColor = Colors.blue.shade300;
      iconColor = Colors.blue.shade400;
    } else {
      backgroundColor = Colors.pink.shade200;
      iconColor = Colors.pink.shade300;
    }

    return GestureDetector(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              spreadRadius: -2,
              blurRadius: 20,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(
                      dataAnak['jenis_kelamin_anak'] == 'Laki-laki'
                          ? FontAwesomeIcons.child
                          : FontAwesomeIcons.childDress,
                      color: iconColor,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataAnak['nama_anak'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dataAnak['jenis_kelamin_anak'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white70),
            const SizedBox(height: 16),
            buildDetailItem('NIK Anak', dataAnak['nik_anak'].toString()),
            buildDetailItem(
                'Tempat Lahir Anak', dataAnak['tempat_lahir_anak'].toString()),
            buildDetailItem('Tanggal Lahir Anak',
                dataAnak['tanggal_lahir_anak'].toString()),
            buildDetailItem(
                'Golongan Darah', dataAnak['gol_darah_anak'].toString()),
            buildDetailItem('Anak Ke', dataAnak['anak_ke'].toString()),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: backgroundColor,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailImunisasi(dataAnak: dataAnak),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Lihat Detail',
                        style: TextStyle(
                          color: backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      FaIcon(
                        FontAwesomeIcons.arrowRight,
                        color: backgroundColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title : ',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
