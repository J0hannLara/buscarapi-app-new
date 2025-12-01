import 'package:flutter/material.dart';

class CategoriaTile extends StatelessWidget {
  final String nombre;
  final bool seleccionada;
  final VoidCallback onTap;

  const CategoriaTile({
    super.key,
    required this.nombre,
    required this.seleccionada,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      color: theme.colorScheme.surface,
      child: CheckboxListTile(
        value: seleccionada,
        title: Text(nombre, style: theme.textTheme.bodyLarge),
        activeColor: theme.colorScheme.primary,
        checkColor: theme.colorScheme.onPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        onChanged: (_) => onTap(),
      ),
    );
  }
}
