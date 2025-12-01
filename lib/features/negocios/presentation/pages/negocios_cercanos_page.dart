import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:buscarapi/core/constants/endpoints.dart';
import 'package:buscarapi/features/negocios/presentation/controllers/negocios_cercanos_controller.dart';
import 'package:buscarapi/features/negocios/presentation/widgets/negocio_info_dialog.dart';
import 'package:buscarapi/core/presentation/widgets/map_legend.dart';

class NegociosCercanosPage extends StatelessWidget {
  const NegociosCercanosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NegociosCercanosController()..obtenerUbicacionYNegocios(),
      child: Consumer<NegociosCercanosController>(
        builder: (context, ctrl, _) {
          if (ctrl.cargando) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body: Column(
              children: [
                _Filtros(
                  radio: ctrl.radio,
                  onBuscar: ctrl.obtenerUbicacionYNegocios,
                ),
                if (ctrl.ubicacionUsuario == null)
                  const Expanded(
                    child: Center(child: Text("Activa la ubicación")),
                  )
                else
                  Expanded(
                    child: Stack(
                      children: [
                        FlutterMap(
                          options: MapOptions(
                            initialCenter: ctrl.ubicacionUsuario!,
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: Endpoints.mapTileUrl,
                              subdomains: const ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 60,
                                  height: 60,
                                  point: ctrl.ubicacionUsuario!,
                                  child: const Icon(
                                    Icons.person_pin_circle,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                                ...ctrl.negocios.expand((negocio) {
                                  return (negocio['sucursales'] as List)
                                      .map((sucursal) {
                                        final lat = double.tryParse(
                                          sucursal['latitud'].toString(),
                                        );
                                        final lng = double.tryParse(
                                          sucursal['longitud'].toString(),
                                        );
                                        if (lat == null || lng == null)
                                          return null;
                                        return Marker(
                                          width: 60,
                                          height: 60,
                                          point: LatLng(lat, lng),
                                          child: GestureDetector(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (_) => NegocioInfoDialog(
                                                negocio: negocio,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.store,
                                              color: Colors.blue,
                                              size: 40,
                                            ),
                                          ),
                                        );
                                      })
                                      .whereType<
                                        Marker
                                      >(); // ✅ filtra los nulls correctamente
                                }),
                              ],
                            ),
                          ],
                        ),
                        const Positioned(
                          right: 10,
                          bottom: 10,
                          child: MapLegend(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Filtros extends StatelessWidget {
  final int radio;
  final VoidCallback onBuscar;
  const _Filtros({required this.radio, required this.onBuscar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Text('Radio (m):'),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '$radio'),
              onChanged: (val) =>
                  context.read<NegociosCercanosController>().radio =
                      int.tryParse(val) ?? radio,
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(onPressed: onBuscar, child: const Text('Buscar')),
        ],
      ),
    );
  }
}
