// lib/features/negocios/presentation/controllers/negocio_detail_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/endpoints.dart';

class NegocioDetailController extends ChangeNotifier {
  Map<String, dynamic>? negocioData;
  bool isLoading = true;
  bool yaLike = false;
  bool yaFavorito = false;

  final int negocioId;
  NegocioDetailController({required this.negocioId});

  Future<void> init() async {
    await fetchNegocioDetalle();
  }

  Future<void> fetchNegocioDetalle() async {
    try {
      isLoading = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      final url = Uri.parse('${Endpoints.baseUrl}/api/negocio/$negocioId${userId != null ? '?id_usuario=$userId' : ''}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        negocioData = jsonDecode(response.body);
        yaLike = negocioData!['yaLike'] ?? false;
        yaFavorito = negocioData!['yaFavorito'] ?? false;
      } else {
        negocioData = null;
      }
    } catch (e) {
      negocioData = null;
      debugPrint('Error fetchNegocioDetalle: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Alterna like / favorito llamando al endpoint de interacciones.
  Future<void> toggleInteraccion(String tipo, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usuarioId = prefs.getInt('userId') ?? 0;

      final url = Uri.parse('${Endpoints.baseUrl}/api/interacciones');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_usuario': usuarioId,
          'tipo': tipo,
          'modelo': 'Negocio',
          'id_modelo': negocioId,
        }),
      );

      if (response.statusCode == 200) {
        if (tipo == 'like') {
          yaLike = !yaLike;
        } else if (tipo == 'favorito') {
          yaFavorito = !yaFavorito;
        }
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tipo == 'like' ? (yaLike ? 'Te gustó este negocio' : 'Se quitó el like') : (yaFavorito ? 'Guardado en favoritos' : 'Se quitó de favoritos'))),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al procesar la interacción')));
      }
    } catch (e) {
      debugPrint('toggleInteraccion error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
