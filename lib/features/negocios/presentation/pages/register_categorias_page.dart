// features/negocios/presentation/pages/register_categorias_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../negocios/presentation/controllers/categorias_controller.dart';
import '../../../negocios/presentation/widgets/categoria_checkbox_tile.dart';
import '../../../negocios/providers/negocio_provider.dart';
import 'personal_negocio_page.dart';

class RegisterCategoriasPage extends StatelessWidget {
  const RegisterCategoriasPage({super.key});

  void _guardarCategorias(BuildContext context) {
    final controller = context.read<CategoriasController>();
    final negocioProvider = context.read<NegocioProvider>();

    if (controller.seleccionadas.isEmpty) {
      controller.errorMessage = "Debes seleccionar al menos una categoría.";
      controller.notifyListeners();
      return;
    }

    final seleccionadas = controller.categorias
        .where((cat) => controller.seleccionadas.contains(cat.id))
        .toList();

    negocioProvider.setCategorias(seleccionadas);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PersonalNegocioPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CategoriasController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Categorías")),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.categorias.isEmpty
              ? Center(
                  child: Text(
                    controller.errorMessage ?? "No hay categorías disponibles",
                    style: theme.textTheme.bodyLarge,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.categorias.length,
                        itemBuilder: (context, index) {
                          final cat = controller.categorias[index];
                          return CategoriaCheckboxTile(
                            categoria: cat,
                            isSelected: controller.seleccionadas.contains(cat.id),
                            onChanged: (_) => controller.toggleCategoria(cat.id),
                          );
                        },
                      ),
                    ),
                    if (controller.errorMessage != null)
                      Text(
                        controller.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () => _guardarCategorias(context),
                      child: const Text("Siguiente"),
                    ),
                  ],
                ),
    );
  }
}
