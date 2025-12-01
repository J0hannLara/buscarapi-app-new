import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/nfc_write_controller.dart';
import '../widgets/nfc_status_widget.dart';

class NfcWritePage extends StatefulWidget {
  final int negocioId;
  final String negocioNombre;

  const NfcWritePage({
    super.key,
    required this.negocioId,
    required this.negocioNombre,
  });

  @override
  State<NfcWritePage> createState() => _NfcWritePageState();
}

class _NfcWritePageState extends State<NfcWritePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NfcWriteController>().startNFCWrite(widget.negocioId);
    });
  }

  @override
  void dispose() {
    context.read<NfcWriteController>().stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NfcWriteController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Escribir en NFC'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: NfcStatusWidget(
            statusMessage: controller.statusMessage,
            isWriting: controller.isWriting,
          ),
        ),
      ),
    );
  }
}
