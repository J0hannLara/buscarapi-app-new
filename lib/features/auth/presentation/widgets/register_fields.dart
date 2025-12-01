import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;

  const RegisterTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: theme.iconTheme.color),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.onSurface, width: 1),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        labelStyle: TextStyle(color: theme.colorScheme.onSurface),
        floatingLabelStyle: TextStyle(color: theme.colorScheme.onSurface),
      ),
    );
  }
}
