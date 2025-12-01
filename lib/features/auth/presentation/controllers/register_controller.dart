import 'package:flutter/material.dart';
import '../../data/datasources/auth_remote_ds.dart';

class RegisterController {
  final AuthRemoteDataSource _remoteDS;

  RegisterController(this._remoteDS);

  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final celularController = TextEditingController();

  bool isLoading = false;

  Future<bool> register() async {
    final nombres = nombresController.text.trim();
    final apellidos = apellidosController.text.trim();
    final celular = celularController.text.trim();

    if (nombres.isEmpty || apellidos.isEmpty || celular.isEmpty) {
      return false;
    }

    isLoading = true;

    final success = await _remoteDS.registerUser(
      nombres: nombres,
      apellidos: apellidos,
      celular: celular,
    );

    isLoading = false;

    return success;
  }

  void dispose() {
    nombresController.dispose();
    apellidosController.dispose();
    celularController.dispose();
  }
}
