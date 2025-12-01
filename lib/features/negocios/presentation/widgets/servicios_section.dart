import 'package:flutter/material.dart';
import 'add_product_service.dart';

class ServiciosSection extends StatelessWidget {
  final List servicios;
  final int negocioId;
  final List sucursales;

  const ServiciosSection({
    super.key,
    required this.servicios,
    required this.negocioId,
    required this.sucursales,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Servicios Registrados", style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...servicios.map((s) => _buildItemCard(s)),
              _buildAddCard(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(Map servicio) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            Image.network(servicio['imagen'] ?? '', height: 100, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(servicio['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddProductServiceView(
              negocioId: negocioId,
              tipo: 'servicios',
              idSucursal: sucursales.isNotEmpty ? sucursales[0]['id'] : 0,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: SizedBox(
          width: 150,
          height: 120,
          child: const Center(child: Icon(Icons.add, size: 40)),
        ),
      ),
    );
  }
}
