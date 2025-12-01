// lib/features/qr/presentation/controllers/qr_controller.dart
import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QrController {
  final GlobalKey globalKey = GlobalKey();

  /// Genera un archivo temporal con el QR actual y lo comparte
  Future<void> shareQR(BuildContext context, int negocioId, String negocioNombre) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/qr_$negocioId.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'QR del negocio "$negocioNombre"',
      );
    } catch (e) {
      debugPrint('Error al compartir QR: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al compartir el QR: ${e.toString()}')),
        );
      }
    }
  }
}
