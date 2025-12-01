import 'package:flutter/material.dart';

class AddProductServiceView extends StatefulWidget {
  final int negocioId;
  final String tipo; // "productos" o "servicios"
  final int idSucursal;

  const AddProductServiceView({
    super.key,
    required this.negocioId,
    required this.tipo,
    required this.idSucursal,
  });

  @override
  State<AddProductServiceView> createState() => _AddProductServiceViewState();
}

class _AddProductServiceViewState extends State<AddProductServiceView> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String descripcion = '';
  double precio = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar ${widget.tipo}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nombre"),
                onSaved: (v) => nombre = v ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descripción"),
                onSaved: (v) => descripcion = v ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number,
                onSaved: (v) => precio = double.tryParse(v ?? '0') ?? 0,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardar,
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardar() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Aquí haces el POST a Laravel
      // negocioId: widget.negocioId
      // tipo: widget.tipo
      // idSucursal: widget.idSucursal

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${widget.tipo} guardado con éxito")),
      );
      Navigator.pop(context);
    }
  }
}
