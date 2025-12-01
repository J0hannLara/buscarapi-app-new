import 'package:flutter/foundation.dart';
import 'package:buscarapi/features/notificaciones/domain/entities/notificacion.dart';
import 'package:buscarapi/features/notificaciones/data/datasources/notificaciones_remote_ds.dart';

class NotificacionesController extends ChangeNotifier {
  final NotificacionesRemoteDs remoteDs;
  final String baseUrl;

  NotificacionesController({required this.remoteDs, required this.baseUrl});

  List<Notificacion> notificaciones = [];
  bool cargando = false;

  Future<void> cargar(int userId) async {
    cargando = true;
    notifyListeners();
    try {
      notificaciones = await remoteDs.fetchNotificaciones(userId, baseUrl);
    } finally {
      cargando = false;
      notifyListeners();
    }
  }

  Future<void> marcarLeida(int id, int userId) async {
    await remoteDs.marcarLeida(id, baseUrl);
    await cargar(userId);
  }
}
