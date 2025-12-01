import 'package:flutter/material.dart';
import '../../../../core/constants/endpoints.dart';

class ItemInfoSection extends StatelessWidget {
  final Map<String, dynamic> itemData;

  const ItemInfoSection({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    final nombre = itemData['nombre'] ?? '';
    final descripcion = itemData['descripcion'] ?? '';
    final imagen = itemData['imagen'];
    final imagenUrl = imagen != null ? '${Endpoints.baseUrl}/$imagen' : 'assets/img/default.jpg';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imagenUrl.startsWith('assets')
            ? Image.asset(imagenUrl, height: 200, width: double.infinity, fit: BoxFit.cover)
            : Image.network(imagen!, height: 200, width: double.infinity, fit: BoxFit.cover),
        const SizedBox(height: 16),
        Text(nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(descripcion),
        const SizedBox(height: 16),
      ],
    );
  }
}
