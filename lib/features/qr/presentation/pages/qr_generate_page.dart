// lib/features/qr/presentation/pages/qr_generate_page.dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/qr_controller.dart';

class QRGeneratePage extends StatefulWidget {
  final int negocioId;
  final String negocioNombre;

  const QRGeneratePage({
    Key? key,
    required this.negocioId,
    required this.negocioNombre,
  }) : super(key: key);

  @override
  State<QRGeneratePage> createState() => _QRGeneratePageState();
}

class _QRGeneratePageState extends State<QRGeneratePage> {
  late QrController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QrController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final qrData = 'buscarapi://negocio/${widget.negocioId}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Código QR - ${widget.negocioNombre}'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: _controller.globalKey,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 250.0,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => _controller.shareQR(
                  context,
                  widget.negocioId,
                  widget.negocioNombre,
                ),
                icon: const Icon(Icons.share),
                label: const Text('Compartir QR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
