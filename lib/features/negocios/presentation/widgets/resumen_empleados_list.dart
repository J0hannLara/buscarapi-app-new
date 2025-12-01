import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/negocio_provider.dart';
import '../../domain/entities/empleado_negocio.dart';

class ResumenEmpleadosList extends StatelessWidget {
  final List<EmpleadoNegocio> empleados;

  const ResumenEmpleadosList({super.key, required this.empleados});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NegocioProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('👥 Empleados añadidos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...empleados.map(
          (e) => ListTile(
            title: Text('${e.nombre} ${e.apellido}'),
            subtitle: Text('${e.celular} - ${e.rol}',
                style: const TextStyle(color: Colors.grey)),
            trailing: e.rol != 'administrador'
                ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.eliminarEmpleado(e.idUsuario),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
