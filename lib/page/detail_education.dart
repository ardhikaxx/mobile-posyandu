import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:mobile_posyandu/controller/artikel_controller.dart';

class DetailEducation extends StatefulWidget {
  final String judul;
  final String gambar;
  final String isi;

  const DetailEducation({
    super.key,
    required this.judul,
    required this.gambar,
    required this.isi,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetailEducationState createState() => _DetailEducationState();
}

class _DetailEducationState extends State<DetailEducation> {
  final ArtikelController artikelController = ArtikelController();

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
        title: const Text(
          'Detail Edukasi',
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(widget.gambar),
              const SizedBox(height: 20),
              Text(
                widget.judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: Color(0xFFDDDDDD), thickness: 2),
              const SizedBox(height: 10),
              Text(
                widget.isi,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              _buildRelatedArticles(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String base64Image) {
    return FutureBuilder(
      future: _loadImage(base64Image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                snapshot.data as Uint8List,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            );
          } else {
            return const SkeletonLoader(
              builder: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                ),
              ),
            );
          }
        } else {
          return const SkeletonLoader(
            builder: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 200,
              ),
            ),
          );
        }
      },
    );
  }

  Future<Uint8List?> _loadImage(String base64Image) async {
    try {
      final cacheManager = DefaultCacheManager();
      final fileInfo = await cacheManager.getFileFromCache(base64Image);
      if (fileInfo != null) {
        return fileInfo.file.readAsBytes();
      } else {
        if (isValidBase64(base64Image)) {
          final imageData = base64.decode(base64Image);
          await cacheManager.putFile(
            base64Image,
            imageData,
            fileExtension: 'jpg',
          );
          return imageData;
        } else {
          throw const FormatException('Invalid base64 string');
        }
      }
    } catch (e) {
      return null;
    }
  }

  bool isValidBase64(String base64String) {
    final base64RegExp = RegExp(r'^[A-Za-z0-9+/]+={0,2}$');
    return base64RegExp.hasMatch(base64String);
  }

  Widget _buildRelatedArticles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related Education',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ArtikelController.artikelData.length,
          itemBuilder: (context, index) {
            final artikel = ArtikelController.artikelData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
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
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.grey.shade300,
                        width: 80,
                        height: 80,
                        child: artikel.gambar.isNotEmpty
                            ? Image.memory(
                                base64.decode(artikel.gambar),
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artikel.judul,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            artikel.isi,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}