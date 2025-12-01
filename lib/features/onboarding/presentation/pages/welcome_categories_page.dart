import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/welcome_controller.dart';
import '../widgets/categoria_tile.dart';

class WelcomeCategoriesPage extends StatelessWidget {
  const WelcomeCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WelcomeController()..cargarCategorias(),
      child: Consumer<WelcomeController>(
        builder: (context, controller, _) {
          final theme = Theme.of(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Selecciona tus categorías', style: theme.textTheme.headlineSmall),
              centerTitle: true,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.categorias.length,
                          padding: const EdgeInsets.all(16),
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final categoria = controller.categorias[index];
                            final id = categoria['id'];
                            final nombre = categoria['nombre'] ?? categoria['descripcion'];
                            final seleccionada = controller.categoriasSeleccionadas.contains(id);

                            return CategoriaTile(
                              nombre: nombre,
                              seleccionada: seleccionada,
                              onTap: () => controller.toggleSeleccion(id),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.save, color: theme.colorScheme.onPrimary),
                            label: Text('Guardar', style: TextStyle(color: theme.colorScheme.onPrimary)),
                            onPressed: () => controller.guardarCategorias(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
