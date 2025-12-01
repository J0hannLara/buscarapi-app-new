import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/personal_negocio_controller.dart';
import '../widgets/empleado_form.dart';
import '../widgets/empleado_list.dart';

class PersonalNegocioPage extends StatelessWidget {
  const PersonalNegocioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PersonalNegocioController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Personal'),
        backgroundColor: colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            EmpleadoForm(),
            if (controller.error != null)
              Text(controller.error!, style: const TextStyle(color: Colors.red)),
            Expanded(child: EmpleadoList()),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ir a resumen negocio
                },
                child: const Text("Siguiente: Resumen"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
