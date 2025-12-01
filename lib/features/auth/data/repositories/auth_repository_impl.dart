// lib/features/auth/data/repositories/auth_repository_impl.dart
import '../datasources/auth_remote_ds.dart';
import '../datasources/auth_local_ds.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.remote, this.local);

  @override
  Future<bool> register(String nombres, String apellidos, String celular) async {
    // Aquí iría tu lógica de registro si aplica
    return true; // placeholder
  }

  @override
  Future<bool> login(String nombre, String celular) async {
    final data = await remote.login(nombre, celular);

    if (data != null) {
      final user = data['user'];
      int userId = int.tryParse(user['id'].toString()) ?? 0;
      bool primeraVez = user['primera_vez'] == true || user['primera_vez'] == 1;

      await local.saveUser(userId, nombre, celular, primeraVez);
      return true;
    }
    return false;
  }

  @override
  Future<bool> isFirstTime() async {
    return await local.isFirstTime();
  }
}
