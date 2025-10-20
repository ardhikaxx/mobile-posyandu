import 'package:flutter/material.dart';
import 'package:mobile_posyandu/components/card_artikel.dart';
import 'package:mobile_posyandu/controller/artikel_controller.dart';
import 'package:mobile_posyandu/page/detail_education.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class Education extends StatefulWidget {
  final dynamic userData;
  const Education({super.key, required this.userData});

  @override
  // ignore: library_private_types_in_public_api
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  ArtikelController artikelController = ArtikelController();

  @override
  void initState() {
    super.initState();
    fetchArtikelData();
  }

  Future<void> fetchArtikelData() async {
    try {
      await artikelController.fetchArtikelData(context);
      setState(() {});
    } catch (e) {
      print('Error fetching artikel data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        title: const Text(
          'Edukasi',
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
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Yuk bunda, baca edukasi untuk memperoleh informasi tentang pola asuh, kesehatan untuk pertumbuhan balita.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: artikelController.fetchArtikelData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SkeletonLoader(
                          builder: Card(
                            child: Container(
                              width: double.infinity,
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          items: 1,
                          period: const Duration(seconds: 2),
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[100]!,
                        ),
                      );
                    },
                  );
                } else if (ArtikelController.artikelData.isNotEmpty) {
                  return ListView.builder(
                    itemCount: ArtikelController.artikelData.length,
                    itemBuilder: (context, index) {
                      final artikel = ArtikelController.artikelData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Menambahkan jarak vertikal
                        child: CardArtikel(
                          judul: artikel.judul,
                          gambar: artikel.gambar,
                          index: index,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailEducation(
                                  judul: artikel.judul,
                                  gambar: artikel.gambar,
                                  isi: artikel.isi,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No articles available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}