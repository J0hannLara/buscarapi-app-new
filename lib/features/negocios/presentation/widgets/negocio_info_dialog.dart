import 'package:flutter/material.dart';
import 'package:buscarapi/features/negocios/presentation/pages/negocio_detail_page_user.dart';

class NegocioInfoDialog extends StatelessWidget {
  final Map<String, dynamic> negocio;

  const NegocioInfoDialog({super.key, required this.negocio});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        negocio['nombre'],
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (negocio['imagen'] != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                negocio['imagen'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 10),
          Text(negocio['descripcion'] ?? ''),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cerrar"),
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NegocioDetailPage(negocioId: negocio['id']),
            ),
          ),
          child: const Text("Visitar negocio"),
        ),
      ],
    );
  }
}
