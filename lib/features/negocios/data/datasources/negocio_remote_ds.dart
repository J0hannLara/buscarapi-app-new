import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/endpoints.dart';
import '../../domain/entities/negocio.dart';

class NegocioRemoteDataSource {
  Future<Map<String, dynamic>> fetchNegocioDetails(int negocioId) async {
    final response = await http.get(
      Uri.parse('${Endpoints.baseUrl}/api/negocio/$negocioId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar negocio');
    }
  }
  
  Future<List<Negocio>> fetchUserNegocios(int userId) async {
    final response = await http.get(
      Uri.parse('${Endpoints.baseUrl}/api/negocios/$userId'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((e) => Negocio(
                id: e['id'],
                nombre: e['nombre'],
                descripcion: e['descripcion'],
                imagen: e['imagen'],
              ))
          .toList();
    } else {
      throw Exception('Error al cargar negocios');
    }
  }
}
