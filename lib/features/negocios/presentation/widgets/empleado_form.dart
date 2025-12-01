import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/personal_negocio_controller.dart';

class EmpleadoForm extends StatefulWidget {
  @override
  State<EmpleadoForm> createState() => _EmpleadoFormState();
}

class _EmpleadoFormState extends State<EmpleadoForm> {
  final _celularController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PersonalNegocioController>();

    return Column(
      children: [
        TextField(
          controller: _celularController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: "Celular del Usuario"),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: controller.rolSeleccionado,
          items: ['administrador', 'encargado', 'empleado']
              .map((rol) => DropdownMenuItem(value: rol, child: Text(rol)))
              .toList(),
          onChanged: (valor) {
            if (valor != null) controller.cambiarRol(valor);
          },
          decoration: const InputDecoration(labelText: "Rol del Usuario"),
        ),
        const SizedBox(height: 16),
        controller.buscando
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                onPressed: () => controller.buscarUsuario(_celularController.text),
                icon: const Icon(Icons.person_add),
                label: const Text("Agregar Usuario"),
              ),
      ],
    );
  }
}
