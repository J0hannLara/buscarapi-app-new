import '../../domain/entities/notificacion.dart';

class NotificacionDto {
  static Notificacion fromJson(Map<String, dynamic> json) {
    return Notificacion(
      id: json['id'],
      mensaje: json['mensaje'],
      createdAt: json['created_at'],
      leido: json['leido'] == 1,
    );
  }
}
