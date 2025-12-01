import 'package:flutter/material.dart';

class NegocioInfoSection extends StatelessWidget {
  final Map<String, dynamic> negocio;

  const NegocioInfoSection({super.key, required this.negocio});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Negocio: ${negocio['nombre']}", style: const TextStyle(fontSize: 18)),
        Text("Descripción: ${negocio['descripcion']}"),
        const SizedBox(height: 16),
      ],
    );
  }
}
