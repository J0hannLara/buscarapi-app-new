import 'package:flutter/material.dart';
import '../../../../../features/negocios/presentation/pages/negocio_list_page.dart';
import '../../../qr/presentation/pages/qr_scan_page.dart';
import '../pages/nfc_scan_page.dart';
import 'nfc_option_button.dart';

class NFCOptionsList extends StatelessWidget {
  const NFCOptionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NFCOptionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NegocioListPage(seleccionandoParaNFC: true),
              ),
            );
          },
          icon: Icons.store,
          label: 'Registrar negocio en NFC',
          backgroundColor: colorScheme.primary,
          textColor: colorScheme.onPrimary,
        ),
        const SizedBox(height: 20),
        NFCOptionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NFCScanPage()),
            );
          },
          icon: Icons.nfc,
          label: 'Escanear NFC',
          backgroundColor: colorScheme.primary,
          textColor: colorScheme.onPrimary,
        ),
        const SizedBox(height: 20),
        NFCOptionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRScanPage()),
            );
          },
          icon: Icons.qr_code,
          label: 'Escanear QR',
          backgroundColor: colorScheme.primary,
          textColor: colorScheme.onPrimary,
        ),
        const SizedBox(height: 20),
        NFCOptionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NegocioListPage(seleccionandoParaQR: true),
              ),
            );
          },
          icon: Icons.qr_code,
          label: 'Generar QR para negocio',
          backgroundColor: colorScheme.primary,
          textColor: colorScheme.onPrimary,
        ),
      ],
    );
  }
}
