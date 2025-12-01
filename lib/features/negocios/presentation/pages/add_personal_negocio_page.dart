import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/negocio_provider.dart';
import '../controllers/add_personal_negocio_controller.dart';
import '../widgets/add_empleado_list.dart';
import 'resumen_negocio_page.dart';

class AddPersonalNegocioPage extends StatefulWidget {
  const AddPersonalNegocioPage({super.key});

  @override
  State<AddPersonalNegocioPage> createState() => _AddPersonalNegocioPageState();
}

class _AddPersonalNegocioPageState extends State<AddPersonalNegocioPage> {
  final TextEditingController _celularController = TextEditingController();
  String _rolSeleccionado = 'encargado';

  @override
  void initState() {
    super.initState();
    final controller = context.read<AddPersonalNegocioController>();
    controller.cargarUsuarioLogueado();
  }

  @override
  Widget build(BuildContext context) {
    final negocioProvider = context.watch<NegocioProvider>();
    final controller = context.watch<AddPersonalNegocioController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Personal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Celular input
            TextField(
              controller: _celularController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Celular del Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Rol selector
            DropdownButtonFormField<String>(
              value: _rolSeleccionado,
              items: ['administrador', 'encargado', 'empleado']
                  .map((rol) => DropdownMenuItem(
                        value: rol,
                        child: Text(rol),
                      ))
                  .toList(),
              onChanged: (valor) {
                setState(() => _rolSeleccionado = valor!);
              },
              decoration: const InputDecoration(
                labelText: 'Rol del Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Botón agregar usuario
            controller.buscando
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: () => controller.buscarUsuarioPorCelular(
                        _celularController.text.trim(), _rolSeleccionado),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Agregar Usuario'),
                  ),

            if (controller.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(controller.error!,
                    style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),

            // Lista de empleados
            Expanded(child: AddEmpleadoList(empleados: negocioProvider.empleados)),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ResumenNegocioPage(onConfirmar: () {})));
              },
              child: const Text('Siguiente: Resumen'),
            ),
          ],
        ),
      ),
    );
  }
}
