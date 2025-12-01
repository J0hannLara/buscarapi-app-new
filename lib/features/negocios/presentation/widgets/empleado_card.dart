import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/personal_negocio_controller.dart';
import '../../domain/entities/empleado_negocio.dart';

class EmpleadoCard extends StatelessWidget {
  final EmpleadoNegocio emp;

  const EmpleadoCard({super.key, required this.emp});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PersonalNegocioController>();

    return Card(
      child: ListTile(
        title: Text(emp.nombre),
        subtitle: Text("${emp.celular} - ${emp.rol}"),
        trailing: emp.rol != 'administrador'
            ? IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => controller.eliminarEmpleado(emp.idUsuario),
              )
            : null,
      ),
    );
  }
}
