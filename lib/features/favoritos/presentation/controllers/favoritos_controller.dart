import 'package:flutter/material.dart';
import '../../../favoritos/data/datasources/favoritos_remote_ds.dart';
import '../../../favoritos/domain/entities/favoritos.dart';

class FavoritosController extends ChangeNotifier {
  final FavoritosRemoteDataSource remoteDataSource;

  FavoritosController({required this.remoteDataSource});

  List<Favorito> favoritos = [];
  bool loading = false;

  Future<void> loadFavoritos(int userId) async {
    loading = true;
    notifyListeners();

    try {
      favoritos = await remoteDataSource.fetchFavoritos(userId);
    } catch (e) {
      favoritos = [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
