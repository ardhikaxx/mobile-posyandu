import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ArtikelController {
  static String apiUrl = 'http://192.168.100.171:8000';
  static List<Artikel> artikelData = [];

  Future<void> fetchArtikelData(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse("${ArtikelController.apiUrl}/api/edukasi"),
      );
      if (response.statusCode == 200) {
        final jsonGet = jsonDecode(response.body) as Map<String, dynamic>;
        final artikelDataFromApi = jsonGet['data'] as List<dynamic>;

        artikelData = artikelDataFromApi.map((artikelJson) {
          return Artikel.fromJson(artikelJson);
        }).toList();
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}

class Artikel {
  final String judul;
  final String isi;
  final String gambar;

  Artikel({
    required this.judul,
    required this.isi,
    required this.gambar,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      judul: json['judul'] ?? '',
      isi: json['isi'] ?? '',
      gambar: json['gambar'] ?? '',
    );
  }
}