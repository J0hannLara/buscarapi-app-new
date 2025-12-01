import 'package:flutter/material.dart';
import '../../data/datasources/negocio_remote_ds.dart';

class NegocioController extends ChangeNotifier {
  final NegocioRemoteDataSource remoteDs;

  NegocioController(this.remoteDs);

  Map<String, dynamic>? negocioData;
  List productos = [];
  List servicios = [];
  List categorias = [];
  List empleados = [];
  List promociones = [];
  List sucursales = [];
  bool isLoading = true;

  Future<void> loadNegocioDetails(int negocioId) async {
    isLoading = true;
    notifyListeners();

    final data = await remoteDs.fetchNegocioDetails(negocioId);

    negocioData = data['negocio'];
    productos = data['productos'];
    servicios = data['servicios'];
    categorias = data['categorias'];
    empleados = data['empleados'];
    promociones = data['promociones'] ?? [];
    sucursales = data['sucursales'];

    isLoading = false;
    notifyListeners();
  }
}
