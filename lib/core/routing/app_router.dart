import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/main_screen.dart';
import '../../features/onboarding/presentation/pages/welcome_categories_page.dart';
import '../../features/negocios/presentation/pages/negocio_detail_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const LoginPage()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
    GoRoute(path: '/bienvenida', builder: (_, __) => const WelcomeCategoriesPage()),
    GoRoute(path: '/main', builder: (_, __) => const MainScreen()),

    GoRoute(
      path: '/negocio/:id',
      builder: (_, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        return NegocioDetailPage(negocioId: id!);
      },
    ),
  ],
);
