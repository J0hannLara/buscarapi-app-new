import 'package:flutter/material.dart';

class EmpleadosSection extends StatelessWidget {
  final List empleados;

  const EmpleadosSection({super.key, required this.empleados});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Empleados", style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        ...empleados.map((emp) => ListTile(
              leading: const Icon(Icons.person),
              title: Text(emp['nombre'] ?? ''),
              subtitle: Text(emp['rol'] ?? ''),
            )),
      ],
    );
  }
}
