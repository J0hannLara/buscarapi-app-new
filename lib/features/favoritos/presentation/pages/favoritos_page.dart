import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/favoritos_controller.dart';
import '../widgets/favorito_card.dart';
import '../../../negocios/presentation/pages/negocio_detail_page_user.dart';

class FavoritosPage extends StatefulWidget {
  final int idUsuario;

  const FavoritosPage({super.key, required this.idUsuario});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final controller = Provider.of<FavoritosController>(context, listen: false);
      controller.loadFavoritos(widget.idUsuario);
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FavoritosController>(context);

    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.favoritos.isEmpty) {
      return const Center(child: Text("No tienes favoritos aún."));
    }

    return ListView.builder(
      itemCount: controller.favoritos.length,
      itemBuilder: (context, index) {
        final favorito = controller.favoritos[index];
        return FavoritoCard(
          favorito: favorito,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NegocioDetailPage(negocioId: favorito.id),
              ),
            );
          },
        );
      },
    );
  }
}
