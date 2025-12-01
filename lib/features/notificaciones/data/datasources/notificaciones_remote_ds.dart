import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buscarapi/features/notificaciones/domain/entities/notificacion.dart';
import 'package:buscarapi/features/notificaciones/data/models/notificacion_dto.dart';

class NotificacionesRemoteDs {
  final http.Client client;
  NotificacionesRemoteDs(this.client);

  Future<List<Notificacion>> fetchNotificaciones(int userId, String baseUrl) async {
    final url = Uri.parse('$baseUrl/api/usuarios/$userId/notificaciones');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data'])
          .map(NotificacionDto.fromJson)
          .toList();
    } else {
      throw Exception('Error al cargar notificaciones');
    }
  }

  Future<void> marcarLeida(int id, String baseUrl) async {
    final url = Uri.parse('$baseUrl/api/notificaciones/$id/leer');
    await client.post(url);
  }
}
