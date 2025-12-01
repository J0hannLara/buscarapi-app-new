import '../../domain/entities/empleado_negocio.dart';
import '../../domain/repositories/empleado_repository.dart';
import '../datasources/empleado_remote_ds.dart';

class EmpleadoRepositoryImpl implements EmpleadoRepository {
  final EmpleadoRemoteDataSource remote;

  EmpleadoRepositoryImpl(this.remote);

  @override
  Future<EmpleadoNegocio?> buscarUsuario(String celular, String rol) async {
    final data = await remote.buscarUsuarioPorCelular(celular);
    if (data == null || data['id'] == null) return null;

    return EmpleadoNegocio(
      idUsuario: data['id'],
      nombre: data['nombres'] ?? 'Sin nombre',
      apellido: data['apellidos'] ?? 'Sin apellido',
      celular: data['celular'].toString(),
      rol: rol,
    );
  }
}
