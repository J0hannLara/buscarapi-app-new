import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constants/endpoints.dart';

class HomeController extends ChangeNotifier {
  List<dynamic> negocios = [];
  List<dynamic> productos = [];
  List<dynamic> servicios = [];
  bool isLoading = true;

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('${Endpoints.baseUrl}/api/cargarNegocios'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        negocios = data['negocios'];
        productos = data['productos'];
        servicios = data['servicios'];
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
