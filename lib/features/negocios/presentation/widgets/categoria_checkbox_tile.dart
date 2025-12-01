// features/negocios/presentation/widgets/categoria_checkbox_tile.dart
import 'package:flutter/material.dart';
import '../../domain/entities/categoria.dart';

class CategoriaCheckboxTile extends StatelessWidget {
  final Categoria categoria;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const CategoriaCheckboxTile({
    Key? key,
    required this.categoria,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return CheckboxListTile(
      value: isSelected,
      onChanged: onChanged,
      title: Text(
        categoria.nombre,
        style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
      ),
      subtitle: categoria.descripcion != null
          ? Text(
              categoria.descripcion!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            )
          : null,
      activeColor: colorScheme.secondary,
      checkColor: colorScheme.onSecondary,
    );
  }
}
