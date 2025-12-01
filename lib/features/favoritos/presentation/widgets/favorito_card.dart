import 'package:flutter/material.dart';
import '../../../favoritos/domain/entities/favoritos.dart';

class FavoritoCard extends StatelessWidget {
  final Favorito favorito;
  final VoidCallback onTap;

  const FavoritoCard({super.key, required this.favorito, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: favorito.imagen != null
            ? Image.network(
                favorito.imagen!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported),
        title: Text(favorito.nombre),
        subtitle: Text(favorito.descripcion),
        trailing: const Icon(Icons.favorite, color: Colors.red),
        onTap: onTap,
      ),
    );
  }
}
