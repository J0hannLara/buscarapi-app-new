// lib/features/negocios/presentation/pages/negocio_detail_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/negocio_detail_controller.dart';
import '../widgets/negocio_detail_widgets.dart';

class NegocioDetailPage extends StatelessWidget {
  final int negocioId;
  const NegocioDetailPage({super.key, required this.negocioId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NegocioDetailController>(
      create: (_) {
        final ctrl = NegocioDetailController(negocioId: negocioId);
        ctrl.init();
        return ctrl;
      },
      child: const _NegocioDetailView(),
    );
  }
}

class _NegocioDetailView extends StatelessWidget {
  const _NegocioDetailView();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<NegocioDetailController>();

    if (ctrl.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (ctrl.negocioData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Negocio')),
        body: const Center(child: Text('No se pudo cargar el negocio')),
      );
    }

    final negocio = ctrl.negocioData!['negocio'] ?? {};
    final productos = ctrl.negocioData!['productos'] ?? [];
    final servicios = ctrl.negocioData!['servicios'] ?? [];
    final promociones = ctrl.negocioData!['promociones'] ?? [];
    final categorias = ctrl.negocioData!['categorias'] ?? [];
    final sucursales = ctrl.negocioData!['sucursales'] ?? [];

    final nombre = negocio['nombre'] ?? 'Negocio';

    return Scaffold(
      appBar: AppBar(title: Text(nombre)),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          negocio['imagen'] != null
              ? Image.network(negocio['imagen'], fit: BoxFit.cover)
              : Container(height: 200, color: Colors.grey[300]),
          Padding(padding: const EdgeInsets.all(12), child: Text(negocio['descripcion'] ?? '', style: const TextStyle(fontSize: 16))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
              icon: Icon(ctrl.yaLike ? Icons.thumb_up : Icons.thumb_up_off_alt, color: ctrl.yaLike ? Colors.blue : Colors.grey),
              onPressed: () => ctrl.toggleInteraccion('like', context),
            ),
            IconButton(
              icon: Icon(ctrl.yaFavorito ? Icons.favorite : Icons.favorite_border, color: ctrl.yaFavorito ? Colors.red : Colors.grey),
              onPressed: () => ctrl.toggleInteraccion('favorito', context),
            ),
          ]),
          sectionTitle("Categorías"),
          categoriasChips(categorias),
          sectionTitle("Promociones"),
          promocionesExpansion(promociones),
          sectionTitle("Productos"),
          listItemsCard(productos),
          sectionTitle("Servicios"),
          listItemsCard(servicios),
          sectionTitle("Sucursales y Contacto"),
          Column(children: sucursales.map<Widget>((s) {
            return ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(s['ubicacion'] ?? 'Sin dirección'),
              subtitle: Text('Celular: ${s['celular'] ?? '---'}'),
            );
          }).toList()),
          if (sucursales.isNotEmpty) ...[
            sectionTitle("Ubicación en el mapa"),
            mapaSucursalWidget(sucursales[0]),
          ],
          sectionTitle("Reseñas"),
          Column(children: [
            ListTile(leading: const Icon(Icons.star, color: Colors.amber), title: const Text('Excelente atención y productos de calidad.')),
            ListTile(leading: const Icon(Icons.star, color: Colors.amber), title: const Text('Muy recomendable, volveré pronto.')),
          ]),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
