import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/presentation/widgets/appbar_widget.dart';
import '../../../../core/presentation/widgets/bottom_nav_bar.dart';
import 'package:buscarapi/features/favoritos/presentation/pages/favoritos_page.dart';
import 'package:buscarapi/features/negocios/presentation/pages/negocios_cercanos_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../notificaciones/presentation/pages/notificaciones_page.dart';
import '../../../perfil/presentation/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int userId = 0;
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadUserData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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

  @override
  Widget build(BuildContext context) {
    if (userId == 0) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppbarWidget(title: _getTitle()),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: _getPages(),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
