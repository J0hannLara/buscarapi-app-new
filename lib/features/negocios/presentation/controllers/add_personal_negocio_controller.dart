import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/endpoints.dart';
import '../../providers/negocio_provider.dart';
import '../../domain/entities/empleado_negocio.dart';

class AddPersonalNegocioController extends ChangeNotifier {
  final NegocioProvider provider;
  bool buscando = false;
  String? error;

  AddPersonalNegocioController(this.provider);

  Future<void> cargarUsuarioLogueado() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('userId') ?? 0;
    final nombre = prefs.getString('nombre') ?? "Usuario";
    final celular = prefs.getString('celular') ?? "No disponible";

    provider.agregarEmpleado(
      EmpleadoNegocio(
        idUsuario: id,
        nombre: nombre,
        apellido: "",
        celular: celular,
        rol: 'administrador',
      ),
    );
  }

  Future<void> buscarUsuarioPorCelular(String celular, String rol) async {
    if (celular.isEmpty) return;

    buscando = true;
    error = null;
    notifyListeners();

    try {
      final url = Uri.parse('${Endpoints.baseUrl}/api/buscarUsuarioPorCelular/$celular');
      final response = await http.get(url);

      final decoded = json.decode(response.body);
      final usuario = (decoded is Map && decoded.containsKey('usuario'))
          ? decoded['usuario']
          : decoded;

      if (usuario == null || usuario['id'] == null) {
        error = 'Usuario inválido.';
        return;
      }

      if (provider.empleados.any((e) => e.idUsuario == usuario['id'])) {
        error = 'Este usuario ya fue agregado.';
      } else {
        provider.agregarEmpleado(
          EmpleadoNegocio(
            idUsuario: usuario['id'],
            nombre: usuario['nombres'] ?? 'Sin nombre',
            apellido: usuario['apellidos'] ?? 'Sin apellido',
            celular: usuario['celular'].toString(),
            rol: rol,
          ),
        );
      }
    } catch (e) {
      error = 'Error inesperado.';
    } finally {
      buscando = false;
      notifyListeners();
    }
  }
}
