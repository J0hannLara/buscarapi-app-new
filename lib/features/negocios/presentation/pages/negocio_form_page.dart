import 'package:buscarapi/features/negocios/presentation/pages/register_categorias_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/preferences/preferences_helper.dart';
import '../controllers/negocio_form_controller.dart';
import '../widgets/negocio_image_picker.dart';
import '../widgets/negocio_form_fields.dart'; 

class NegocioFormPage extends StatelessWidget {
  const NegocioFormPage({super.key});

  Future<void> _guardarDatos(BuildContext context) async {
    final controller = context.read<NegocioFormController>();

    final nombre = controller.nombreController.text.trim();
    final descripcion = controller.descripcionController.text.trim();

    if (nombre.isEmpty || descripcion.isEmpty) {
      controller.setError("Por favor, completa todos los campos.");
      return;
    }

    final userId = Preferences.getInt("userId");

    if (userId == null) {
      controller.setError("No se encontró el usuario.");
      return;
    }

    // Aquí podrías pasar al siguiente paso (categorías)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterCategoriasPage(), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NegocioFormController(),
      child: Consumer<NegocioFormController>(
        builder: (context, controller, _) {
          final theme = Theme.of(context);

          return Scaffold(
            appBar: AppBar(
              title: Text("Datos del negocio",
                  style: TextStyle(color: theme.colorScheme.secondary)),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.secondary,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  NegocioFormFields(
                    nombreController: controller.nombreController,
                    descripcionController: controller.descripcionController,
                  ),
                  const SizedBox(height: 20),
                  NegocioImagePicker(
                    selectedImage: controller.selectedImage,
                    onImageSelected: controller.setImage,
                  ),
                  if (controller.errorMessage != null)
                    Text(controller.errorMessage!,
                        style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 20),
                  controller.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _guardarDatos(context),
                          child: const Text("Siguiente"),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
