import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/negocio_provider.dart';
import '../../domain/entities/empleado_negocio.dart';

class AddEmpleadoList extends StatelessWidget {
  final List<EmpleadoNegocio> empleados;

  const AddEmpleadoList({super.key, required this.empleados});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NegocioProvider>();
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: empleados.length,
      itemBuilder: (context, index) {
        final emp = empleados[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text(emp.nombre, style: theme.textTheme.titleMedium),
            subtitle: Text('${emp.celular} - ${emp.rol}'),
            trailing: emp.rol != 'administrador'
                ? IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => provider.eliminarEmpleado(emp.idUsuario),
                  )
                : null,
          ),
        );
      },
    );
  }
}
