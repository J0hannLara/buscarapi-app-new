import 'package:flutter/material.dart';

class NegocioHeader extends StatelessWidget {
  final Map<String, dynamic>? negocioData;

  const NegocioHeader({super.key, required this.negocioData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagen de portada
        if (negocioData?['imagen'] != null)
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(negocioData!['imagen']),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          Container(
            height: 200,
            width: double.infinity,
            color: theme.colorScheme.secondary.withOpacity(0.3),
            child: const Icon(Icons.store, size: 100),
          ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                negocioData?['nombre'] ?? 'Negocio',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                negocioData?['descripcion'] ?? 'Descripción no disponible',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
