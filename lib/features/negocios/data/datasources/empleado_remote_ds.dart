import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/endpoints.dart';

class EmpleadoRemoteDataSource {
  final http.Client client;

  EmpleadoRemoteDataSource(this.client);

  Future<Map<String, dynamic>?> buscarUsuarioPorCelular(String celular) async {
    final url = Uri.parse('${Endpoints.baseUrl}/api/buscarUsuarioPorCelular/$celular');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded is Map && decoded.containsKey('usuario')
          ? decoded['usuario']
          : decoded;
    }
    return null;
  }
}
