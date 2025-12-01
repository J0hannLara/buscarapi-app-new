import 'package:flutter/material.dart';
import '../../domain/entities/negocio.dart';
import '../../data/datasources/negocio_remote_ds.dart';
import '../../../../core/preferences/preferences_helper.dart';

class NegocioListController extends ChangeNotifier {
  final NegocioRemoteDataSource remoteDs;

  NegocioListController(this.remoteDs);

  List<Negocio> negocios = [];
  bool isLoading = false;

  Future<void> loadNegocios() async {
    isLoading = true;
    notifyListeners();

    final userId = await Preferences.getInt('userId') ?? 0;

    try {
      negocios = await remoteDs.fetchUserNegocios(userId);
    } catch (e) {
      negocios = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
