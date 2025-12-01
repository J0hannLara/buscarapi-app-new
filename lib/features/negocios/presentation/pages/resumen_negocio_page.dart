import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/negocio_provider.dart';
import '../controllers/resumen_negocio_controller.dart';
import '../widgets/resumen_empleados_list.dart';
import '../widgets/resumen_seccion_estatica.dart';

class ResumenNegocioPage extends StatefulWidget {
  final VoidCallback onConfirmar;

  const ResumenNegocioPage({super.key, required this.onConfirmar});

  @override
  State<ResumenNegocioPage> createState() => _ResumenNegocioPageState();
}

class _ResumenNegocioPageState extends State<ResumenNegocioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _celularController;
  late TextEditingController _ubicacionController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<NegocioProvider>();
    _celularController = TextEditingController(text: provider.celularSucursal);
    _ubicacionController = TextEditingController(text: provider.ubicacionSucursal);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NegocioProvider>();
    final controller = context.watch<ResumenNegocioController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Resumen del Negocio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ResumenSeccionEstatica(
                titulo: '🏪 Nombre del negocio',
                contenido: provider.nombre,
              ),
              ResumenSeccionEstatica(
                titulo: '📝 Descripción',
                contenido: provider.descripcion,
              ),
              if (provider.imagen != null) ...[
                const Text('📷 Imagen del negocio', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Image.file(provider.imagen!, height: 200),
                const SizedBox(height: 16),
              ],
              ResumenSeccionEstatica(
                titulo: '📚 Categorías seleccionadas',
                contenido: provider.categoriasSeleccionadas.isEmpty
                    ? 'No se seleccionaron categorías'
                    : provider.categoriasSeleccionadas.map((c) => c.nombre).join(', '),
              ),
              const SizedBox(height: 20),
              ResumenEmpleadosList(empleados: provider.empleados),

              const SizedBox(height: 15),
              TextFormField(
                controller: _celularController,
                decoration: const InputDecoration(labelText: '📞 Celular de la sucursal'),
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty) ? 'Campo obligatorio' : null,
                onChanged: (v) => provider.setSucursal(v, _ubicacionController.text),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _ubicacionController,
                decoration: const InputDecoration(labelText: '📍 Ubicación de la sucursal'),
                validator: (v) => (v == null || v.isEmpty) ? 'Campo obligatorio' : null,
                onChanged: (v) => provider.setSucursal(_celularController.text, v),
              ),

              const SizedBox(height: 15),
              ElevatedButton.icon(
                icon: const Icon(Icons.location_on),
                label: const Text('Usar mi ubicación actual'),
                onPressed: () => controller.usarUbicacionActual(provider, context),
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                icon: controller.isLoading
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.check_circle),
                label: Text(controller.isLoading ? 'Guardando...' : 'Confirmar y continuar'),
                onPressed: controller.isLoading
                    ? null
                    : () => controller.confirmarYGuardar(
                          ctx: context,
                          provider: provider,
                          formKey: _formKey,
                          onSuccess: () => Navigator.pushReplacementNamed(context, '/home'),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
