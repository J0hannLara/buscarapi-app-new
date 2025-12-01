// lib/features/negocios/presentation/widgets/negocio_detail_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget mapaSucursalWidget(Map sucursal) {
  double lat = double.tryParse((sucursal['latitud'] ?? '0').toString()) ?? 0.0;
  double lng = double.tryParse((sucursal['longitud'] ?? '0').toString()) ?? 0.0;

  return Container(
    height: 250,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
    child: FlutterMap(
      options: MapOptions(initialCenter: LatLng(lat, lng), initialZoom: 16),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=kSzOVWNzma80OVRqN91q',
          userAgentPackageName: 'com.miapp.negocios',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(lat, lng),
              width: 80,
              height: 80,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget categoriasChips(List categorias) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Wrap(
      spacing: 6,
      children: categorias.map<Widget>((cat) {
        final descripcion = cat['descripcion'] ?? cat['nombre'] ?? '';
        return Chip(label: Text(descripcion));
      }).toList(),
    ),
  );
}

Widget listItemsCard(List items) {
  return Column(
    children: items.map<Widget>((item) {
      final imagen = item['imagen'];
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: imagen != null
              ? Image.network(imagen, width: 50, height: 50, fit: BoxFit.cover)
              : const Icon(Icons.image_not_supported),
          title: Text(item['nombre'] ?? 'Sin nombre'),
          subtitle: Text(item['descripcion'] ?? 'Sin descripción'),
          trailing: Text('Bs. ${item['precio'] ?? '---'}'),
        ),
      );
    }).toList(),
  );
}

Widget promocionesExpansion(List promos) {
  return Column(
    children: promos.map<Widget>((promo) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 3,
        child: ExpansionTile(
          title: Text('Promoción Bs. ${promo['precioPromocion'] ?? ''}'),
          subtitle: Text('Antes: Bs. ${promo['precio'] ?? ''}'),
          children: [
            ...((promo['productos'] ?? []) as List).map<Widget>(
              (prod) => ListTile(
                title: Text(prod['nombre'] ?? ''),
                subtitle: Text(prod['descripcion'] ?? ''),
                leading: prod['imagen'] != null
                    ? Image.network(prod['imagen'], width: 50)
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            ...((promo['servicios'] ?? []) as List).map<Widget>(
              (serv) => ListTile(
                title: Text(serv['nombre'] ?? ''),
                subtitle: Text(serv['descripcion'] ?? ''),
                leading: serv['imagen'] != null
                    ? Image.network(serv['imagen'], width: 50)
                    : const Icon(Icons.image_not_supported),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
