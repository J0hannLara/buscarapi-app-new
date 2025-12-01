import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/nfc_scan_controller.dart';
import '../widgets/nfc_status_scan.dart';

class NFCScanPage extends StatelessWidget {
  const NFCScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NFCScanController()..startNFCScan(context),
      child: Consumer<NFCScanController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Escanear NFC'),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: NFCStatusScanWidget(
                  message: controller.statusMessage,
                  isLoading: controller.isScanning,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
