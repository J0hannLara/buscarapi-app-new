import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/controllers/negocio_controller.dart';
import '../../data/datasources/negocio_remote_ds.dart';
import '../widgets/negocio_header.dart';
import '../widgets/productos_section.dart';
import '../widgets/servicios_section.dart';
import '../widgets/empleados_section.dart';
import '../widgets/categorias_section.dart';
import '../widgets/promociones_section.dart';

class NegocioDetailPage extends StatelessWidget {
  final int negocioId;

  const NegocioDetailPage({super.key, required this.negocioId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          NegocioController(NegocioRemoteDataSource())..loadNegocioDetails(negocioId),
      child: Consumer<NegocioController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(title: const Text("Detalles del Negocio")),
            body: RefreshIndicator(
              onRefresh: () => controller.loadNegocioDetails(negocioId),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NegocioHeader(negocioData: controller.negocioData),
                    ProductosSection(
                      productos: controller.productos,
                      negocioId: negocioId,
                      sucursales: controller.sucursales,
                    ),
                    ServiciosSection(
                      servicios: controller.servicios,
                      negocioId: negocioId,
                      sucursales: controller.sucursales,
                    ),
                    PromocionesSection(
                      promociones: controller.promociones,
                      productos: controller.productos,
                      servicios: controller.servicios,
                      negocioId: negocioId,
                      sucursales: controller.sucursales,
                    ),
                    EmpleadosSection(empleados: controller.empleados),
                    CategoriasSection(categorias: controller.categorias),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
