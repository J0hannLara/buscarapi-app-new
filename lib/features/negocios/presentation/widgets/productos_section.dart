import 'package:flutter/material.dart';
import 'add_product_service.dart';

class ProductosSection extends StatelessWidget {
  final List productos;
  final int negocioId;
  final List sucursales;

  const ProductosSection({
    super.key,
    required this.productos,
    required this.negocioId,
    required this.sucursales,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Productos Registrados", style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...productos.map((p) => _buildItemCard(p)),
              _buildAddCard(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(Map producto) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            Image.network(producto['imagen'] ?? '', height: 100, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(producto['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
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
              tipo: 'productos',
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
