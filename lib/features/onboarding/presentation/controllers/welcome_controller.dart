import 'package:buscarapi/core/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constants/endpoints.dart';

class WelcomeController extends ChangeNotifier {
  List<Map<String, dynamic>> categorias = [];
  List<int> categoriasSeleccionadas = [];
  bool isLoading = true;

  Future<void> cargarCategorias() async {
    isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    final responseCat = await http.get(Uri.parse('${Endpoints.baseUrl}/api/categorias'));
    final responseUsuarioCat = await http.get(Uri.parse('${Endpoints.baseUrl}/api/usuario-categorias/$userId'));

    if (responseCat.statusCode == 200 && responseUsuarioCat.statusCode == 200) {
      categorias = List<Map<String, dynamic>>.from(json.decode(responseCat.body));
      categoriasSeleccionadas = List<int>.from(json.decode(responseUsuarioCat.body));
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleSeleccion(int idCategoria) {
    if (categoriasSeleccionadas.contains(idCategoria)) {
      categoriasSeleccionadas.remove(idCategoria);
    } else {
      categoriasSeleccionadas.add(idCategoria);
    }
    notifyListeners();
  }

  Future<void> guardarCategorias(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    final response = await http.post(
      Uri.parse('${Endpoints.baseUrl}/api/guardar-categorias-usuario'),
      body: {
        'id_usuario': userId.toString(),
        'categorias': categoriasSeleccionadas.join(','),
      },
    );

    if (response.statusCode == 200) {
      await prefs.setBool('primera_vez', false);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
