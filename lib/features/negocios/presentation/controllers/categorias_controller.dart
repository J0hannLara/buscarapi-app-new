// features/negocios/presentation/controllers/categorias_controller.dart
import 'package:flutter/material.dart';
import '../../../negocios/domain/entities/categoria.dart';
import '../../../negocios/data/datasources/categorias_remote_ds.dart';

class CategoriasController extends ChangeNotifier {
  final CategoriasRemoteDataSource dataSource;

  CategoriasController(this.dataSource);

  List<Categoria> categorias = [];
  Set<int> seleccionadas = {};
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadCategorias() async {
    isLoading = true;
    notifyListeners();

    try {
      categorias = await dataSource.fetchCategorias();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleCategoria(int id) {
    if (seleccionadas.contains(id)) {
      seleccionadas.remove(id);
    } else {
      seleccionadas.add(id);
    }
    notifyListeners();
  }
}
