import 'package:flutter/material.dart';

class PromocionesSection extends StatelessWidget {
  final List promociones;
  final List productos;
  final List servicios;
  final int negocioId;
  final List sucursales;

  const PromocionesSection({
    super.key,
    required this.promociones,
    required this.productos,
    required this.servicios,
    required this.negocioId,
    required this.sucursales,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Promociones", style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Column(
          children: [
            ...promociones.map((promo) => _buildPromoCard(promo)),
            _buildAddPromoCard(context),
          ],
        ),
      ],
    );
  }

  Widget _buildPromoCard(Map promo) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(promo['titulo'] ?? 'Promo'),
        subtitle: Text(promo['descripcion'] ?? ''),
        trailing: Text("${promo['descuento'] ?? ''}%"),
      ),
    );
  }

  Widget _buildAddPromoCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aquí iría la navegación a una vista de agregar promoción
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ir a agregar promoción")),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: const Center(child: Icon(Icons.add, size: 40)),
        ),
      ),
    );
  }
}
