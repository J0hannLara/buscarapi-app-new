import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/endpoints.dart';

class AuthRemoteDataSource {
  final String baseUrl = '${Endpoints.baseUrl}/api';

  Future<Map<String, dynamic>?> login(String nombre, String celular) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'nombre': nombre, 'celular': celular},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }
  Future<bool> register(String nombres, String apellidos, String celular) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      body: json.encode({
        'nombres': nombres,
        'apellidos': apellidos,
        'celular': celular,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 201;
  }

  final String _registerUrl = '${Endpoints.baseUrl}/api/usuarios';

  Future<bool> registerUser({
    required String nombres,
    required String apellidos,
    required String celular,
  }) async {
    final response = await http.post(
      Uri.parse(_registerUrl),
      body: json.encode({
        'nombres': nombres,
        'apellidos': apellidos,
        'celular': celular,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 201;
  }
}
