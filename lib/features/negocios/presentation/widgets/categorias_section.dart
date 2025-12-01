import 'package:flutter/material.dart';

class CategoriasSection extends StatelessWidget {
  final List categorias;

  const CategoriasSection({super.key, required this.categorias});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Categorías", style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Wrap(
          spacing: 8,
          children: categorias
              .map((c) => Chip(
                    label: Text(c['nombre'] ?? ''),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
