import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constants/endpoints.dart';

class DetalleItemController extends ChangeNotifier {
  final int itemId;
  final String tipo; // 'producto' o 'servicio'

  bool isLoading = true;
  Map<String, dynamic>? itemData;
  Map<String, dynamic>? negocio;
  List<dynamic> sucursales = [];

  DetalleItemController({required this.itemId, required this.tipo});

  Future<void> fetchDetalle() async {
    isLoading = true;
    notifyListeners();

    try {
      final url = '${Endpoints.baseUrl}/api/obtener_$tipo/$itemId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        itemData = json.decode(response.body);

        if (tipo == 'producto' && itemData?['negocio_producto']?.isNotEmpty == true) {
          negocio = itemData!['negocio_producto'][0]['negocio'];
          sucursales = negocio?['sucursales'] ?? [];
        } else if (tipo == 'servicio' && itemData?['negocio_servicio']?.isNotEmpty == true) {
          negocio = itemData!['negocio_servicio'][0]['negocio'];
          sucursales = negocio?['sucursales'] ?? [];
        }
      }
    } catch (e) {
      print("Error al cargar detalle: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
