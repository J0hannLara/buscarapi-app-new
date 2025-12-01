import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/routing/app_router.dart';
import 'core/presentation/theme/theme.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/negocios/presentation/controllers/negocio_controller.dart';
import 'core/preferences/preferences_helper.dart';
import 'features/negocios/providers/negocio_provider.dart';
import 'features/favoritos/data/datasources/favoritos_remote_ds.dart';
import 'features/favoritos/presentation/controllers/favoritos_controller.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    await Preferences.init();
    await setupLocator();

    runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthController(locator())),
        ChangeNotifierProvider(
            create: (_) => NegocioController(locator())),
        ChangeNotifierProvider(create: (_) => NegocioProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoritosController(
            remoteDataSource: FavoritosRemoteDataSource(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
  } catch (e, s) {
    debugPrint("❌ Error al iniciar la app: $e");
    debugPrint("$s");
    runApp(MaterialApp(home: Scaffold(
      body: Center(child: Text("Error: $e")),
    )));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tu App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter, // 👈 en vez de hardcodear routes
    );
  }
}
