import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/personal_negocio_controller.dart';
import 'empleado_card.dart';

class EmpleadoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PersonalNegocioController>();

    return ListView.builder(
      itemCount: controller.empleados.length,
      itemBuilder: (_, i) {
        final emp = controller.empleados[i];
        return EmpleadoCard(emp: emp);
      },
    );
  }
}
