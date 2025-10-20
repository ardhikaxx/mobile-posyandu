import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImunisasi extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const DetailImunisasi({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          'Detail Imunisasi',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
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
                width: double.infinity,
                height: 65,
                child: const Center(
                  child: Text(
                    'Riwayat Posyandu dan Imunisasi Anak',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: dataAnak['posyandu'] != null && dataAnak['posyandu'].isNotEmpty
                  ? ListView.builder(
                      itemCount: dataAnak['posyandu'].length,
                      itemBuilder: (context, index) {
                        final posyanduData = dataAnak['posyandu'][index];
                        return Card(
                          color: const Color(0xFF006BFA),
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shadowColor: Colors.blueGrey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Posyandu: ${posyanduData['tanggal_posyandu'] ?? '-'}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Divider(color: Colors.white.withOpacity(0.8)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildDetailItem('Tinggi Badan', '${posyanduData['tb_anak'] ?? '-'} cm'),
                                    buildDetailItem('Berat Badan', '${posyanduData['bb_anak'] ?? '-'} kg'),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildDetailItem('Umur Anak', '${posyanduData['umur_anak'] ?? '-'} bulan'),
                                    buildDetailItem(
                                      'Nama Vaksin',
                                      posyanduData['nama_vaksin'] != null
                                          ? (posyanduData['nama_vaksin'] as List).join(', ')
                                          : '-',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tidak ada data posyandu dan imunisasi',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}