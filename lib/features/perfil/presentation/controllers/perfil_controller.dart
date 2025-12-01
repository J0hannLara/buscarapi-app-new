import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilController extends ChangeNotifier {
  String _nombre = "Usuario";
  String _celular = "No disponible";
  int _userId = 0;
  bool _isLoggedIn = false;

  String get nombre => _nombre;
  String get celular => _celular;
  int get userId => _userId;
  bool get isLoggedIn => _isLoggedIn;

  /// Cargar datos de SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _nombre = prefs.getString('nombre') ?? "Usuario";
    _celular = prefs.getString('celular') ?? "No disponible";
    _userId = prefs.getInt('userId') ?? 0;
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  /// Guardar datos de usuario
  Future<void> saveUserData({
    required String nombre,
    required String celular,
    required int userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', nombre);
    await prefs.setString('celular', celular);
    await prefs.setInt('userId', userId);
    await prefs.setBool('isLoggedIn', true);

    _nombre = nombre;
    _celular = celular;
    _userId = userId;
    _isLoggedIn = true;
    notifyListeners();
  }

  /// Cerrar sesión
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    notifyListeners();
  }
}
