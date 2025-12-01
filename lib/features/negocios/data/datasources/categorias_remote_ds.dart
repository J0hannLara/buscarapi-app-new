// features/negocios/data/datasources/categorias_remote_ds.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/endpoints.dart';
import '../models/categoria_dto.dart';

class CategoriasRemoteDataSource {
  Future<List<CategoriaDto>> fetchCategorias() async {
    final response = await http.get(Uri.parse('${Endpoints.baseUrl}/api/categorias'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => CategoriaDto.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar categorías");
    }
  }
}
