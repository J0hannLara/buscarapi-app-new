abstract class AuthRepository {
  Future<bool> register(String nombres, String apellidos, String celular);
  Future<bool> login(String nombre, String celular);
  Future<bool> isFirstTime();
}
