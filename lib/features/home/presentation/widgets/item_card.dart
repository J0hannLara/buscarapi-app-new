import 'package:flutter/material.dart';
import '../../../negocios/presentation/pages/negocio_detail_page_user.dart';
import '../../../catalogo/presentation/pages/detalle_item_page.dart';

class ItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final String tipo;

  const ItemCard({super.key, required this.item, required this.tipo});

  @override
  Widget build(BuildContext context) {
    String negocioNombre = "Desconocido";

    if (tipo == 'servicios' && item['negocio_servicio']?.isNotEmpty == true) {
      negocioNombre = item['negocio_servicio'][0]['negocio']['nombre'] ?? "Desconocido";
    }
    if (tipo == 'productos' && item['negocio_producto']?.isNotEmpty == true) {
      negocioNombre = item['negocio_producto'][0]['negocio']['nombre'] ?? "Desconocido";
    }

    final imagen = item['imagen'];
    final imageProvider = imagen != null
        ? NetworkImage(imagen)
        : const AssetImage('assets/img/default.jpg') as ImageProvider;

    return GestureDetector(
      onTap: () {
        if (tipo == 'negocios') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NegocioDetailPage(negocioId: item['id']),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetalleItemPage(
                itemId: item['id'],
                tipo: tipo == 'productos' ? 'producto' : 'servicio',
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 320,
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['nombre'] ?? "Sin nombre",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      tipo == 'negocios' ? item['descripcion'] ?? "Sin descripción" : 'Negocio: $negocioNombre',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
