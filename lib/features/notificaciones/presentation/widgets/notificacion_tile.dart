import 'package:flutter/material.dart';
import 'package:buscarapi/features/notificaciones/domain/entities/notificacion.dart';

class NotificacionTile extends StatelessWidget {
  final Notificacion notif;
  final VoidCallback onTap;

  const NotificacionTile({super.key, required this.notif, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(
        notif.leido ? Icons.notifications : Icons.notifications_active,
        color: notif.leido
            ? colorScheme.onSecondary.withOpacity(0.4)
            : colorScheme.secondary,
      ),
      title: Text(
        notif.mensaje,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        notif.createdAt,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      tileColor: notif.leido
          ? colorScheme.surface
          : colorScheme.primary.withOpacity(0.1),
      onTap: onTap,
    );
  }
}
