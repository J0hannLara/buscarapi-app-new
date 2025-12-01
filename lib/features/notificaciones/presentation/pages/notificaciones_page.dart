import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:buscarapi/features/notificaciones/presentation/controllers/notificaciones_controller.dart';
import 'package:buscarapi/features/notificaciones/presentation/widgets/notificacion_tile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:buscarapi/features/notificaciones/data/datasources/notificaciones_remote_ds.dart';

class NotificacionesPage extends StatelessWidget {
  final int usuarioId;

  const NotificacionesPage({super.key, required this.usuarioId});

  @override
  Widget build(BuildContext context) {
    final baseUrl = dotenv.env['BASE_URL']!;
    return ChangeNotifierProvider(
      create: (_) => NotificacionesController(
        remoteDs: NotificacionesRemoteDs(http.Client()),
        baseUrl: baseUrl,
      )..cargar(usuarioId),
      child: Consumer<NotificacionesController>(
        builder: (context, ctrl, _) {
          if (ctrl.cargando) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body: ListView.builder(
              itemCount: ctrl.notificaciones.length,
              itemBuilder: (context, i) {
                final notif = ctrl.notificaciones[i];
                return NotificacionTile(
                  notif: notif,
                  onTap: () => ctrl.marcarLeida(notif.id, usuarioId),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
