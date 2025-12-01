import 'package:buscarapi/core/preferences/preferences_helper.dart';

class AuthLocalDataSource {
  Future<void> saveUser(
    int userId,
    String nombre,
    String celular,
    bool primeraVez,
  ) async {
    await Preferences.setInt('userId', userId);
    await Preferences.setString('nombre', nombre);
    await Preferences.setString('celular', celular);
    await Preferences.setBool('primera_vez', primeraVez);
    await Preferences.setBool('isLoggedIn', true);
  }

  Future<bool> isFirstTime() async {
    return Preferences.getBool('primera_vez') ?? true;
  }
}
