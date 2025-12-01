import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefs;

  // Inicializa las preferencias (llamar en main.dart)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Guardar datos
  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Obtener datos
  static int? getInt(String key) => _prefs?.getInt(key);

  static String? getString(String key) => _prefs?.getString(key);

  static bool? getBool(String key) => _prefs?.getBool(key);

  // Eliminar
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
