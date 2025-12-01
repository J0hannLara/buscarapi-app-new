import 'package:flutter/material.dart';

class MapLegend extends StatelessWidget {
  const MapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_pin_circle, color: Colors.red),
              Text("  Tú", style: TextStyle(color: colorScheme.primary)),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.store, color: Colors.blue),
              Text("  Negocios", style: TextStyle(color: colorScheme.primary)),
            ],
          ),
        ],
      ),
    );
  }
}
