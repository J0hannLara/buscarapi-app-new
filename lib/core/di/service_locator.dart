import 'package:buscarapi/features/auth/domain/repositories/auth_repository.dart';
import 'package:buscarapi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:buscarapi/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:buscarapi/features/auth/data/datasources/auth_local_ds.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Data sources
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  locator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator(), locator()));

  // Aquí tus otros providers, como NegocioRemoteDataSource, etc.
}
