import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:buscarapi/core/constants/endpoints.dart';

class NegociosCercanosController extends ChangeNotifier {
  LatLng? ubicacionUsuario;
  List<Map<String, dynamic>> negocios = [];
  int radio = 500;
  bool cargando = false;

  Future<void> obtenerUbicacionYNegocios() async {
    cargando = true;
    notifyListeners();

    final permiso = await Geolocator.requestPermission();
    if (permiso == LocationPermission.denied ||
        permiso == LocationPermission.deniedForever) {
      cargando = false;
      notifyListeners();
      return;
    }

    final posicion = await Geolocator.getCurrentPosition();
    ubicacionUsuario = LatLng(posicion.latitude, posicion.longitude);

    final response = await http.get(
      Uri.parse(
        '${Endpoints.baseUrl}/api/negocio/obtener-negocios-cercanos?lat=${posicion.latitude}&lng=${posicion.longitude}&radio=$radio',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      negocios = List<Map<String, dynamic>>.from(data['negocios']);
    }

    cargando = false;
    notifyListeners();
  }
}
