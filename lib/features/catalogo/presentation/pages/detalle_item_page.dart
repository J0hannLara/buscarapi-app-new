import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/detalle_item_controller.dart';
import '../widgets/item_info_section.dart';
import '../widgets/negocio_info_section.dart';
import '../widgets/sucursales_list.dart';

class DetalleItemPage extends StatelessWidget {
  final int itemId;
  final String tipo;

  const DetalleItemPage({super.key, required this.itemId, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetalleItemController(itemId: itemId, tipo: tipo)..fetchDetalle(),
      child: Consumer<DetalleItemController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return Scaffold(
              appBar: AppBar(title: const Text('Cargando...')),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.itemData == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Detalle')),
              body: Center(child: Text('No se encontró el $tipo.')),
            );
          }

          return Scaffold(
            appBar: AppBar(title: Text(controller.itemData!['nombre'] ?? 'Detalle')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemInfoSection(itemData: controller.itemData!),
                  if (controller.negocio != null) ...[
                    NegocioInfoSection(negocio: controller.negocio!),
                    SucursalesList(sucursales: controller.sucursales),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
