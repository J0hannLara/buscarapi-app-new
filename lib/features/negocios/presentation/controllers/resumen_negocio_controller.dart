import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/endpoints.dart';
import '../../providers/negocio_provider.dart';

class ResumenNegocioController extends ChangeNotifier {
  bool isLoading = false;

  Future<void> enviarNegocio(NegocioProvider provider) async {
    final uri = Uri.parse('${Endpoints.baseUrl}/api/guardar-negocio');
    final request = http.MultipartRequest('POST', uri);

    // Campos normales
    request.fields.addAll({
      'nombre': provider.nombre,
      'descripcion': provider.descripcion,
      'userId': provider.userId.toString(),
      'celularSucursal': provider.celularSucursal,
      'ubicacionSucursal': provider.ubicacionSucursal,
      'latitudSucursal': provider.latitudSucursal?.toString() ?? '',
      'longitudSucursal': provider.longitudSucursal?.toString() ?? '',
    });

    // Imagen
    if (provider.imagen != null) {
      request.files.add(
        await http.MultipartFile.fromPath('imagen', provider.imagen!.path),
      );
    }

    // Categorías
    request.fields['categorias'] =
        jsonEncode(provider.categoriasSeleccionadas.map((c) => c.id).toList());

    // Empleados
    final empleadosJson = provider.empleados
        .map((e) => {
              'idUsuario': e.idUsuario,
              'nombre': e.nombre,
              'apellido': e.apellido,
              'celular': e.celular,
              'rol': e.rol,
            })
        .toList();
    request.fields['empleados'] = jsonEncode(empleadosJson);

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (response.statusCode != 201) {
      throw Exception('Error al crear negocio: ${res.body}');
    }
  }

  Future<void> usarUbicacionActual(NegocioProvider provider, BuildContext ctx) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Permiso de ubicación denegado permanentemente')),
        );
        return;
      }

      final posicion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      provider.setCoordenadasSucursal(posicion.latitude, posicion.longitude);

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Ubicación: ${posicion.latitude}, ${posicion.longitude}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Error al obtener ubicación: $e')),
      );
    }
  }

  Future<void> confirmarYGuardar({
    required BuildContext ctx,
    required NegocioProvider provider,
    required GlobalKey<FormState> formKey,
    required VoidCallback onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) return;

    final confirmar = await showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('¿Deseas guardar este negocio y continuar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sí, guardar'),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    isLoading = true;
    notifyListeners();

    try {
      await enviarNegocio(provider);
      provider.limpiar();
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Negocio guardado exitosamente.')),
        );
        onSuccess();
      }
    } catch (e) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
