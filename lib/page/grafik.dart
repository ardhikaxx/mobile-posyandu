import 'package:flutter/material.dart';
import 'package:mobile_posyandu/components/card_grafik.dart';
import 'package:mobile_posyandu/controller/grafik_controller.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class Grafik extends StatefulWidget {
  final dynamic userData;
  const Grafik({super.key, required this.userData});

  @override
  State<Grafik> createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (GrafikController.posyanduData.isEmpty) {
      fetchPosyanduData();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchPosyanduData() async {
    try {
      await GrafikController.fetchPosyanduData(context);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        title: const Text(
          'Grafik',
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
                'Timbanglah Anak Anda Setiap Bulan Anak Sehat, Tambah Umur Tambah Berat, Tambah Pandai',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? SkeletonLoader(
                    builder: const CardAnakSkeleton(),
                    items: 4,
                    period: const Duration(seconds: 2),
                    highlightColor: Colors.grey[100]!,
                    baseColor: Colors.grey[300]!,
                  )
                : _errorMessage != null
                    ? Center(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : GrafikController.posyanduData.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tidak ada data anak',
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
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: GrafikController.posyanduData.length,
                            itemBuilder: (context, index) {
                              final dataAnak = GrafikController
                                  .posyanduData[
                                      GrafikController.posyanduData.length -
                                          1 -
                                          index]; // Membalik urutan data
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: CardAnak(dataAnak: dataAnak),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

class CardAnakSkeleton extends StatelessWidget {
  const CardAnakSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(
              builder: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              items: 1,
              period: const Duration(seconds: 2),
              highlightColor: Colors.grey[100]!,
              baseColor: Colors.grey[300]!,
            ),
            const SizedBox(height: 8),
            SkeletonLoader(
              builder: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              items: 1,
              period: const Duration(seconds: 2),
              highlightColor: Colors.grey[100]!,
              baseColor: Colors.grey[300]!,
            ),
          ],
        ),
      ),
    );
  }
}