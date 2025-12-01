import 'package:flutter/material.dart';

class SucursalesList extends StatelessWidget {
  final List<dynamic> sucursales;

  const SucursalesList({super.key, required this.sucursales});

  @override
  Widget build(BuildContext context) {
    if (sucursales.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sucursales:", style: TextStyle(fontWeight: FontWeight.bold)),
        ...sucursales.map((sucursal) => ListTile(
              leading: const Icon(Icons.store),
              title: Text(sucursal['ubicacion'] ?? 'Sin ubicación'),
              subtitle: Text("Celular: ${sucursal['celular'] ?? 'No disponible'}"),
            )),
      ],
    );
  }
}
