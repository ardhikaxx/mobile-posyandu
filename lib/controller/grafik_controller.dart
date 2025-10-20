import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mobile_posyandu/controller/auth_controller.dart';

class GrafikController {
  static String apiUrl = "http://192.168.100.171:8000";
  static List posyanduData = [];

  static void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }

  static Future<void> fetchPosyanduData(BuildContext context) async {
    try {
      final noKk = AuthController().getNoKk();
      if (noKk == null) {
        throw Exception('No KK not found');
      }

      final responseData = await http.get(
        Uri.parse("${GrafikController.apiUrl}/api/auth/dataGrafik?no_kk=$noKk"),
      );

      if (responseData.statusCode == 200) {
        final jsonData = jsonDecode(responseData.body) as Map<String, dynamic>;
        posyanduData = jsonData['data'];
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}