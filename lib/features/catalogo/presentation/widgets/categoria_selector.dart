import 'package:flutter/material.dart';

class Categoria {
  final int id;
  final String nombre;

  const Categoria({required this.id, required this.nombre});
}

class CategoriaSelector extends StatelessWidget {
  final List<Categoria> categorias;
  final List<int> seleccionadas;
  final void Function(List<int>) onChanged;

  const CategoriaSelector({
    super.key,
    required this.categorias,
    required this.seleccionadas,
    required this.onChanged,
  });

  void _toggleCategoria(int id) {
    final nuevaSeleccion = List<int>.from(seleccionadas);
    if (nuevaSeleccion.contains(id)) {
      nuevaSeleccion.remove(id);
    } else {
      nuevaSeleccion.add(id);
    }
    onChanged(nuevaSeleccion);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categorias.map((categoria) {
        final isSelected = seleccionadas.contains(categoria.id);
        return CheckboxListTile(
          value: isSelected,
          title: Text(
            categoria.nombre,
            style: TextStyle(color: theme.textTheme.bodyLarge?.color),
          ),
          activeColor: theme.colorScheme.primary,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          onChanged: (_) => _toggleCategoria(categoria.id),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        );
      }).toList(),
    );
  }
}
