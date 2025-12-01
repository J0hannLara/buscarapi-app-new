import '../entities/empleado_negocio.dart';

abstract class EmpleadoRepository {
  Future<EmpleadoNegocio?> buscarUsuario(String celular, String rol);
}
