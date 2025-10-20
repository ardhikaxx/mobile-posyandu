import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:image_card/image_card.dart';

class CardArtikel extends StatelessWidget {
  final String judul;
  final String gambar;
  final Function onTap;
  final int index;

  const CardArtikel({
    super.key,
    required this.judul,
    required this.gambar,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _loadImage(gambar),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: onTap as void Function()?,
              child: TransparentImageCard(
                width: double.infinity,
                imageProvider: MemoryImage(snapshot.data!),
                tags: [_tag('Edukasi', onTap)],
                title: _title(judul, color: Colors.white),
              ),
            );
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else {
            return _buildSkeletonLoader();
          }
        } else {
          return _buildSkeletonLoader();
        }
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return const SkeletonLoader(
      builder: Card(
        child: SizedBox(
          width: double.infinity,
          height: 220,
        ),
      ),
    );
  }

  Widget _title(String title, {required Color color}) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: color,
      ),
    );
  }

  Widget _tag(String text, Function onTap) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: const Color(0xFF006BFA),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> _loadImage(String base64Image) async {
    final cacheManager = DefaultCacheManager();

    while (true) {
      try {
        final fileInfo = await cacheManager.getFileFromCache(base64Image);
        if (fileInfo != null) {
          return fileInfo.file.readAsBytes();
        } else {
          final imageData = base64.decode(base64Image);
          await cacheManager.putFile(
            base64Image,
            imageData,
            fileExtension: 'jpg',
          );
          return imageData;
        }
      } catch (e) {
        print('Error loading image: $e');
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }
}