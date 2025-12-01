import 'package:buscarapi/features/negocios/presentation/pages/personal_negocio_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Features
import 'package:buscarapi/features/home/presentation/pages/home_page.dart';
import 'package:buscarapi/features/favoritos/presentation/pages/favoritos_page.dart';
import 'package:buscarapi/features/negocios/presentation/pages/negocios_cercanos_page.dart';
import 'package:buscarapi/features/notificaciones/presentation/pages/notificaciones_page.dart';
import 'package:buscarapi/features/perfil/presentation/pages/profile_page.dart';

// Core widgets
import 'package:buscarapi/core/presentation/widgets/appbar_widget.dart';
import 'package:buscarapi/core/presentation/widgets/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int userId = 0;
  int _selectedIndex = 0;
  bool isAddingBusiness = false;
  Widget? _currentView;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      isAddingBusiness = false;
      _selectedIndex = index;
      _currentView = null; // reseteamos si veníamos de otra vista
    });
  }

  void showPersonalNegociosView() {
    setState(() {
      _currentView = const PersonalNegocioPage();
    });
  }

  List<Widget> _getPages() {
    return [
      const HomePage(),
      FavoritosPage(idUsuario: userId),
      const NegociosCercanosPage(),
      NotificacionesPage(usuarioId: userId),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (userId == 0) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppbarWidget(title: _getTitle()),
      body: _currentView ?? _getPages()[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Favoritos';
      case 2:
        return 'Mis Negocios';
      case 3:
        return 'Notificaciones';
      case 4:
        return 'Perfil';
      default:
        return 'App';
    }
  }
}
