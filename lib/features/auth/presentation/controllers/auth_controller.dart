import 'package:flutter/material.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository repository; // ahora depende de la interfaz

  AuthController(this.repository);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String nombre, String celular) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final success = await repository.login(nombre, celular);

    _isLoading = false;
    if (!success) {
      _errorMessage = "Usuario no encontrado o datos incorrectos";
    }
    notifyListeners();

    return success;
  }
}
