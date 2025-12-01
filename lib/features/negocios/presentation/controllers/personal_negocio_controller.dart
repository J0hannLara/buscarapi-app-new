import 'package:flutter/foundation.dart';
import '../../domain/entities/empleado_negocio.dart';
import '../../domain/repositories/empleado_repository.dart';
import 'package:buscarapi/core/preferences/preferences_helper.dart';


class PersonalNegocioController extends ChangeNotifier {
  final EmpleadoRepository repository;
  final List<EmpleadoNegocio> _empleados = [];
  bool _buscando = false;
  String? _error;
  String _rolSeleccionado = 'encargado';

  PersonalNegocioController(this.repository);

  List<EmpleadoNegocio> get empleados => _empleados;
  bool get buscando => _buscando;
  String? get error => _error;
  String get rolSeleccionado => _rolSeleccionado;

  void cambiarRol(String rol) {
    _rolSeleccionado = rol;
    notifyListeners();
  }

  Future<void> cargarUsuarioLogueado() async {
    final nombre = Preferences.getString('nombre') ?? "Usuario";
    final celular = Preferences.getString('celular') ?? "No disponible";
    final id = Preferences.getInt('userId') ?? 0;

    _empleados.add(
      EmpleadoNegocio(
        idUsuario: id,
        nombre: nombre,
        apellido: "",
        celular: celular,
        rol: 'administrador',
      ),
    );
    notifyListeners();
  }

  Future<void> buscarUsuario(String celular) async {
    if (celular.isEmpty) return;

    _buscando = true;
    _error = null;
    notifyListeners();

    try {
      final usuario = await repository.buscarUsuario(celular, _rolSeleccionado);

      if (usuario == null) {
        _error = "Usuario inválido.";
      } else if (_empleados.any((e) => e.idUsuario == usuario.idUsuario)) {
        _error = "Este usuario ya fue agregado.";
      } else {
        _empleados.add(usuario);
      }
    } catch (e) {
      _error = "Error inesperado.";
    } finally {
      _buscando = false;
      notifyListeners();
    }
  }

  void eliminarEmpleado(int idUsuario) {
    _empleados.removeWhere((e) => e.idUsuario == idUsuario);
    notifyListeners();
  }
}
