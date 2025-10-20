import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:mobile_posyandu/components/card_imunisasi.dart';
import 'package:mobile_posyandu/controller/imunisasi_controller.dart';

class Imunisasi extends StatefulWidget {
  final dynamic userData;
  const Imunisasi({super.key, required this.userData});

  @override
  State<Imunisasi> createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (ImunisasiController.imunisasiData.isEmpty) {
      fetchDataImunisasi();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchDataImunisasi() async {
    await ImunisasiController.fetchDataImunisasi(context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        title: const Text(
          'Imunisasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF006BFA),
            fontSize: 25,
          ),
        ),
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Center(
              child: Text(
                'Yuk, Bunda! Pastikan anak kita mendapatkan imunisasi lengkap dan rutin memeriksakan kesehatan di posyandu. Kesehatan si kecil adalah investasi terbesar untuk masa depannya yang cerah!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: _isLoading
                ? SkeletonLoader(
                    builder: Column(
                      children: List.generate(2, (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 125,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 125,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  )
                : ImunisasiController.imunisasiData.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tidak ada Data Anak',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        children: ImunisasiController.imunisasiData.reversed.map((dataAnak) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: CardImunisasi(dataAnak: dataAnak),
                        )).toList(),
                      ),
          ),
        ],
      ),
    );
  }
}