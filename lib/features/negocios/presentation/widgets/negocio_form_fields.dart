import 'package:flutter/material.dart';

class NegocioFormFields extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController descripcionController;

  const NegocioFormFields({
    super.key,
    required this.nombreController,
    required this.descripcionController,
  });

  InputDecoration _decoration(BuildContext context, String label) {
    final colorScheme = Theme.of(context).colorScheme;

    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: colorScheme.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        TextField(
          controller: nombreController,
          decoration: _decoration(context, "Nombre del Negocio"),
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: descripcionController,
          maxLines: 3,
          decoration: _decoration(context, "Descripción"),
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        ),
      ],
    );
  }
}
