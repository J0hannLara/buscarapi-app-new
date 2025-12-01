import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/endpoints.dart';
import '../models/favorito_dto.dart';

class FavoritosRemoteDataSource {
  Future<List<FavoritoDto>> fetchFavoritos(int userId) async {
    final String baseUrl = Endpoints.baseUrl;

    final url = Uri.parse('$baseUrl/api/interacciones/favoritos/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => FavoritoDto.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar favoritos');
    }
  }
}
